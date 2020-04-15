//
//  Movement.swift
//  13033
//
//  Created by Nikolaos Athanasiou on 14/4/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation

struct Movement {
    var id: Int
    var title: String
    
    static var current = [
        Movement(id: 1, title: NSLocalizedString("b1", comment: "The reason for the movement permit")),
        Movement(id: 2, title: NSLocalizedString("b2", comment: "The reason for the movement permit")),
        Movement(id: 3, title: NSLocalizedString("b3", comment: "The reason for the movement permit")),
        Movement(id: 4, title: NSLocalizedString("b4", comment: "The reason for the movement permit")),
        Movement(id: 5, title: NSLocalizedString("b5", comment: "The reason for the movement permit")),
        Movement(id: 6, title: NSLocalizedString("b6", comment: "The reason for the movement permit"))
    ]
}
