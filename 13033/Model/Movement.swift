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
        Movement(id: 1, title: "Φαρμακείο/Γιατρός"),
        Movement(id: 2, title: "Σούπερ Μάρκετ"),
        Movement(id: 3, title: "Τράπεζα"),
        Movement(id: 4, title: "Παροχή Βοήθειας"),
        Movement(id: 5, title: "Τελετή / Διαζευγμένοι Γονείς"),
        Movement(id: 6, title: "Σωματική Άσκηση / Κίνηση με κατοικίδιο")
    ]
}
