//
//  MovementViewController.swift
//  13033
//
//  Created by Nikolaos Athanasiou on 14/4/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import UIKit
import EasyPeasy
import Disk

class MovementViewController: UIViewController {
    var shouldUpdateConstraints = true

    var buttonArray: [UIButton] = []
    var changeUserInfoButton: UIButton!
    
    var activeUser: User!
    
    var messaging = MessageService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
        updateViewConstraints()
        fetchViewData()
    }
    
    func setupView() {
        title = "Μετακίνηση"
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        for movement in Movement.current {
            let mvButton = UIButton(frame: .zero)
            mvButton.setTitle(movement.title, for: .normal)
            mvButton.tag = movement.id
            mvButton.backgroundColor = UIColor(hexString: "#F2F2F2")
            mvButton.setTitleColor(UIColor(hexString: "#1B1F4A"), for: .normal)
            mvButton.roundCorners(.allCorners, radius: 11)
            buttonArray.append(mvButton)
        }
        buttonArray.forEach { view.addSubview($0) }
        
        changeUserInfoButton = UIButton(frame: .zero)
        changeUserInfoButton.setTitle("Αλλαγή Στοιχείων", for: .normal)
        changeUserInfoButton.backgroundColor = UIColor(hexString: "#44D7B6")
        changeUserInfoButton.setTitleColor(.white, for: .normal)
        changeUserInfoButton.roundCorners(.allCorners, radius: 11)
        view.addSubview(changeUserInfoButton)

    }
    
    func setupActions() {
        buttonArray.forEach { button in
            button.addTarget(self, action: #selector(didTapMovementButton(sender:)), for: .touchUpInside)
        }
        
        changeUserInfoButton.addTarget(self, action: #selector(didTapChangeUserInfoButton(sender:)), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(self.fetchViewData), name:NSNotification.Name(rawValue: "userUpdated"), object: nil)

    }
    
    @objc func fetchViewData() {
        do {
        activeUser = try Disk.retrieve("user.json", from: .applicationSupport, as: User.self)
        } catch {
            // User Not found, ask for user information again
            let vc = UserInfoViewController()
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func updateViewConstraints() {
        if shouldUpdateConstraints {
            shouldUpdateConstraints.toggle()
            
            var count = 0
            buttonArray.forEach { button in
                if count == 0 {
                    button.easy.layout(Top(32).to(view, .topMargin))
                } else {
                    button.easy.layout(Top(14).to(buttonArray[count-1], .bottom))
                }
                
                button.easy.layout(
                    Left(18),
                    Right(18),
                    Height(46)
                )
                
                count += 1
            }
            
            changeUserInfoButton.easy.layout(
                Top(14).to(buttonArray.last!, .bottom),
                Left(18),
                Right(18),
                Height(46)
            )
            
        }
        super.updateViewConstraints()
    }

    @objc func didTapMovementButton(sender: Any?) {
        guard let sender = sender as? UIButton else {return}
        messaging.sendMessage(self, forUser: activeUser, withMovementID: sender.tag)
    }
    
    @objc func didTapChangeUserInfoButton(sender: Any?) {
        let vc = UserInfoViewController(user: activeUser)
        self.present(vc, animated: true)
    }
}
