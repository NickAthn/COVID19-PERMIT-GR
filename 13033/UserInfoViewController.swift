//
//  ViewController.swift
//  13033
//
//  Created by Nikolaos Athanasiou on 14/4/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import UIKit
import EasyPeasy
import Disk

class UserInfoViewController: UIViewController {
    var shouldUpdateConstraints = true
    
    var descriptionLabel: UILabel!
    var fullNameTextField: UITextField!
    var homeAddressTextField: UITextField!
    var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        updateViewConstraints()
        setupActions()
        
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        } else {
            // Fallback on earlier versions
        }
    }
    
    func setupView() {
        // View Title
        self.title = "Στοιχεία SMS"
        self.view.backgroundColor = .white
        
        descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.text = "Συμπληρωσε τα στοιχεια που θα χρησημοποιουντε για την αποστολη SMS στο 13033. Τα στοιχεια σου θα αποθηκευτουν τοπικα στο κινητο προσβασιμα μονο απο εσενα."
        descriptionLabel.numberOfLines = 0;
        view.addSubview(descriptionLabel)
        
        fullNameTextField = UITextField(frame: .zero)
        fullNameTextField.attributedPlaceholder = NSAttributedString(string: "Ονοματεπώνυμο",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "#7F7F7F")])
        fullNameTextField.roundCorners(.allCorners, radius: 11)
        fullNameTextField.layer.backgroundColor = UIColor(hexString: "#F2F2F2").cgColor
        view.addSubview(fullNameTextField)
        
        homeAddressTextField = UITextField(frame: .zero)
        homeAddressTextField.attributedPlaceholder = NSAttributedString(string: "Διεύθυνση Κατοικίας",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "#7F7F7F")])
        homeAddressTextField.roundCorners(.allCorners, radius: 11)
        homeAddressTextField.layer.backgroundColor = UIColor(hexString: "#F2F2F2").cgColor
        view.addSubview(homeAddressTextField)
        
        saveButton = UIButton(type: .custom)
        saveButton.setTitle("Αποθήκευση", for: .normal)
        saveButton.backgroundColor = UIColor(hexString: "#44D7B6")
        saveButton.tintColor = .white
        saveButton.roundCorners(.allCorners, radius: 11)
        view.addSubview(saveButton)
    }
    
    func setupActions() {
        saveButton.addTarget(self, action: #selector(didTapSaveButton(sender:)), for: .touchUpInside)
    }
    
    override func updateViewConstraints() {
        if shouldUpdateConstraints {
            shouldUpdateConstraints.toggle()
            
            descriptionLabel.easy.layout(
                Top(20).to(view, .topMargin),
                Left(18),
                Right(18)
            )
            
            fullNameTextField.easy.layout(
                Top(20).to(descriptionLabel, .bottom),
                Left(18),
                Right(18),
                Height(46)
            )
            
            homeAddressTextField.easy.layout(
                Top(20).to(fullNameTextField, .bottom),
                Left(18),
                Right(18),
                Height(46)
            )
            
            saveButton.easy.layout(
                Top(20).to(homeAddressTextField, .bottom),
                Left(18),
                Right(18),
                Height(46)
            )
        }
        super.updateViewConstraints()
    }
    
    @objc func didTapSaveButton(sender: Any?) {
        if fullNameTextField.text != "" && fullNameTextField.text != nil {
            if homeAddressTextField.text != "" && homeAddressTextField.text != nil {
                let user = User(fullName: fullNameTextField.text!.capitalized, address: homeAddressTextField.text!.capitalized)
                do {
                    try Disk.save(user, to: .applicationSupport, as: "user.json")
                    navigateToMovement()
                } catch {
                    print("Error saving user info")
                }
            }
        }
    }
    
    func navigateToMovement() {
        let mVC = MovementViewController()
        self.navigationController?.setViewControllers([mVC], animated: true)
    }
}
