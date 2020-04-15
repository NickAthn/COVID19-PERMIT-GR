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
    
    var activeUser: User!
    convenience init(user: User) {
        self.init()
        activeUser = user
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        updateViewConstraints()
        setupData()
        setupActions()
    }
    
    func setupView() {
        // View Title
        self.title = "Στοιχεία SMS"
        self.view.backgroundColor = ColorScheme().background
        
        
        
        
        descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.text = "Τα παρακάτω στοιχεία θα χρησιμοποιούνται για την αποστολή SMS στο 13033. Τα στοιχειά σου θα αποθηκευτούν τοπικά στο κινητό και θα είναι προσβάσιμα μόνο από εσένα"
        descriptionLabel.font = Font(.installed(.HelveticaNeue), size: .standard(.h5)).instance
        descriptionLabel.textAlignment = .natural
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.allowsDefaultTighteningForTruncation = false
        descriptionLabel.textColor = ColorScheme().backgroundConstast
        descriptionLabel.numberOfLines = 0;
        view.addSubview(descriptionLabel)
        
        fullNameTextField = UITextField(frame: .zero)
        fullNameTextField.attributedPlaceholder = NSAttributedString(string: "Ονοματεπώνυμο",
        attributes: [NSAttributedString.Key.foregroundColor: ColorScheme().surfaceContrastLight])
        fullNameTextField.roundCorners(.allCorners, radius: 11)
        fullNameTextField.backgroundColor = ColorScheme().surface
        fullNameTextField.setLeftPaddingPoints(14)
        fullNameTextField.setRightPaddingPoints(14)

        view.addSubview(fullNameTextField)
        
        homeAddressTextField = UITextField(frame: .zero)
        homeAddressTextField.attributedPlaceholder = NSAttributedString(string: "Διεύθυνση Κατοικίας",
                                                                        attributes: [NSAttributedString.Key.foregroundColor: ColorScheme().surfaceContrastLight])
        homeAddressTextField.roundCorners(.allCorners, radius: 11)
        homeAddressTextField.backgroundColor = ColorScheme().surface
        homeAddressTextField.setLeftPaddingPoints(14)
        homeAddressTextField.setRightPaddingPoints(14)
        view.addSubview(homeAddressTextField)
        
        saveButton = UIButton(type: .custom)
        saveButton.setTitle("Αποθήκευση", for: .normal)
        saveButton.backgroundColor = ColorScheme().theme
        saveButton.setTitleColor(ColorScheme().themeContrast, for: .normal)
        saveButton.titleLabel?.font = Font(.installed(.HelveticaNeueBold), size: .standard(.h3)).instance
        saveButton.tintColor = .white
        saveButton.roundCorners(.allCorners, radius: 11)
        view.addSubview(saveButton)
    }
    
    func setupData() {
        if activeUser != nil {
            fullNameTextField.text = activeUser.fullName
            homeAddressTextField.text = activeUser.address
        }
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
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userUpdated"), object: nil)

                    navigateToMovement()
                } catch {
                    print("Error saving user info")
                }
            }
        }
    }
    
    func navigateToMovement() {
        if self.isModal {
            self.dismiss(animated: true, completion: nil)
        } else {
            let mVC = MovementViewController()
            self.navigationController?.setViewControllers([mVC], animated: true)
        }
    }
}
