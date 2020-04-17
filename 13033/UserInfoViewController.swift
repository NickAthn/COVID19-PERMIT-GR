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
    
    var nameFieldErrorLabel: UILabel!
    var fullNameTextField: SpringTextField!
    
    var homeFieldErrorLabel: UILabel!
    var homeAddressTextField: SpringTextField!
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
        
        fullNameTextField.delegate = self
        homeAddressTextField.delegate = self
    }
    
    func setupView() {
        // View Title
        self.title = NSLocalizedString("infoViewTitle", comment: "")
        self.view.backgroundColor = ColorScheme().background
        
        
        homeFieldErrorLabel = UILabel(frame: .zero)
        homeFieldErrorLabel.text = NSLocalizedString("emptyField", comment: "")
        homeFieldErrorLabel.font = Font(.installed(.HelveticaNeue), size: .standard(.h6)).instance
        homeFieldErrorLabel.textAlignment = .left
        homeFieldErrorLabel.textColor = UIColor.systemRed
        homeFieldErrorLabel.isHidden = true
        view.addSubview(homeFieldErrorLabel)
        nameFieldErrorLabel = UILabel(frame: .zero)
        nameFieldErrorLabel.text = NSLocalizedString("emptyField", comment: "")
        nameFieldErrorLabel.font = Font(.installed(.HelveticaNeue), size: .standard(.h6)).instance
        nameFieldErrorLabel.textAlignment = .left
        nameFieldErrorLabel.textColor = UIColor.systemRed
        nameFieldErrorLabel.isHidden = true
        view.addSubview(nameFieldErrorLabel)

        
        descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.text = NSLocalizedString("infoDescription", comment: "")
        descriptionLabel.font = Font(.installed(.HelveticaNeue), size: .standard(.h5)).instance
        descriptionLabel.textAlignment = .natural
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.allowsDefaultTighteningForTruncation = false
        descriptionLabel.textColor = ColorScheme().backgroundConstast
        descriptionLabel.numberOfLines = 0;
        view.addSubview(descriptionLabel)
        
        fullNameTextField = SpringTextField(frame: .zero)
        fullNameTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("namePlaceholder", comment: ""),
        attributes: [NSAttributedString.Key.foregroundColor: ColorScheme().surfaceContrastLight])
        fullNameTextField.roundCorners(.allCorners, radius: 11)
        fullNameTextField.backgroundColor = ColorScheme().surface
        fullNameTextField.setLeftPaddingPoints(14)
        fullNameTextField.setRightPaddingPoints(14)
        fullNameTextField.returnKeyType = .next

        view.addSubview(fullNameTextField)
        
        homeAddressTextField = SpringTextField(frame: .zero)
        homeAddressTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("addressPlaceholder", comment: ""),
                                                                        attributes: [NSAttributedString.Key.foregroundColor: ColorScheme().surfaceContrastLight])
        homeAddressTextField.roundCorners(.allCorners, radius: 11)
        homeAddressTextField.backgroundColor = ColorScheme().surface
        homeAddressTextField.setLeftPaddingPoints(14)
        homeAddressTextField.setRightPaddingPoints(14)
        homeAddressTextField.returnKeyType = .done

        view.addSubview(homeAddressTextField)
        
        saveButton = UIButton(type: .custom)
        saveButton.setTitle(NSLocalizedString("saveButton", comment: ""), for: .normal)
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
            
            homeFieldErrorLabel.easy.layout(
                Left().to(homeAddressTextField, .left),
                Bottom(1).to(homeAddressTextField, .top)
            )
            nameFieldErrorLabel.easy.layout(
                Left().to(fullNameTextField, .left),
                Bottom(1).to(fullNameTextField, .top)
            )

            
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
        if fullNameTextField.text == "" {
            fullNameTextField.animation = "shake"
            fullNameTextField.animate()
            nameFieldErrorLabel.isHidden = false
        }
        if homeAddressTextField.text == "" {
            homeAddressTextField.animation = "shake"
            homeAddressTextField.animate()
            homeFieldErrorLabel.isHidden = false
        }
        
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
        
        if self.navigationController?.viewControllers.first is MovementViewController {
            navigationController?.popToRootViewController(animated: true)
        } else if self.isModal {
            self.dismiss(animated: true, completion: nil)
        } else {
            let mVC = MovementViewController()
            self.navigationController?.setViewControllers([mVC], animated: true)
        }
    }
}

extension UserInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == fullNameTextField { // Switch focus to other text field
            homeAddressTextField.becomeFirstResponder()
        } else if textField == homeAddressTextField {
            didTapSaveButton(sender: nil)
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if !(textField.text?.isEmpty ?? false) {
            if textField == fullNameTextField {
                nameFieldErrorLabel.isHidden = true
            } else {
                homeFieldErrorLabel.isHidden = true
            }
        }
    }
}
