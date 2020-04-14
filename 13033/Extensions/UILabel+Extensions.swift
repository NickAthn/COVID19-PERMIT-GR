//
//  UILabel + Extensions.swift
//  Food Orderer
//
//  Created by Nikolaos Athanasiou on 14/3/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import UIKit

extension UILabel {
    /// Variable for added letter spacing. Negative or possative values can be used.
    var letterSpace: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let currentAttrString = attributedText {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            } else {
                attributedString = NSMutableAttributedString(string: text ?? "")
                text = nil
            }
            attributedString.addAttribute(NSAttributedString.Key.kern,
                                          value: newValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
        
        get {
            if let currentLetterSpace = attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            } else {
                return 0
            }
        }
    }

    /// Sets font and spacing based on given variable
//    func setFont(_ font: Font) {
//        self.font = font.instance
//        self.letterSpace = font.textSpacing
//    }
}
