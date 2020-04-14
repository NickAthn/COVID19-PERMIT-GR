//
//  CALayer+Extensions.swift
//  Food Orderer
//
//  Created by Nikolaos Athanasiou on 14/3/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import UIKit

extension CALayer {
    /// Replicates shadows from Sketch.
    func applySketchShadow( color: UIColor = .black, alpha: Float = 0.5, x: CGFloat = 0, y: CGFloat = 2, blur: CGFloat = 4, spread: CGFloat = 0) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
