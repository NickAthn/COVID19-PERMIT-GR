//
//  ViewController.swift
//  13033
//
//  Created by Nikolaos Athanasiou on 14/4/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import UIKit
import EasyPeasy

class ViewController: UIViewController {
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


}
