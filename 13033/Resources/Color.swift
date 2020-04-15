//
//  Color.swift
//  13033
//
//  Created by Nikolaos Athanasiou on 15/4/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import UIKit

struct ColorScheme {
    /// Dynamic Colors
    var theme =  UIColor(named: "theme")
    var themeContrast = UIColor(named: "themeContrast")
    
    var background = UIColor(named: "background")
    var backgroundConstast = UIColor(named: "backgroundContrast")
    
    var surface = UIColor(named: "surface")
    var surfaceContrast = UIColor(named: "surfaceContrast")
    var surfaceContrastLight = UIColor(named: "surfaceContrastLight")
}
