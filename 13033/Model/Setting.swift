//
//  Setting.swift
//  13033
//
//  Created by Nikolaos Athanasiou on 15/4/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import UIKit

enum SettingID: String {
    case
    bug = "bug",
    terms = "terms",
    privacy = "privacy",
    share = "share",
    review = "review"
}

struct SettingsSection {
    var title: String
    var footer: String = ""
    var settings: [Setting]
    
    
}
struct Setting {
    var id: String
    var title: String
    var image: UIImage
    var isLink: Bool = false
    
    static var sections = [
        SettingsSection(
            title: "HELP",
            footer: "",
            settings: [
                Setting(id: "bug", title: "Report a bug", image: UIImage(named: "bugReportIcon")!),
                Setting(id: "terms", title: "Terms of Use", image: UIImage(named: "termsOfUseIcon")!),
                Setting(id: "privacy", title: "Privacy Policy", image: UIImage(named: "privacyPolicyIcon")!)
        ]),
        SettingsSection(
            title: "LOVE THE APP? ❤️",
            footer: "Version 1.",
            settings: [
                Setting(id: "share", title: "Share", image: UIImage(named: "shareIcon")!),
                Setting(id: "review", title: "Review 13033 App", image: UIImage(named: "appStoreIcon")!, isLink: true)
        ])
    ]
}


