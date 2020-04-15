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
            title: NSLocalizedString("helpHeader", comment: ""),
            footer: "",
            settings: [
                Setting(id: "bug", title: NSLocalizedString("bugSetting", comment: ""), image: UIImage(named: "bugReportIcon")!),
                Setting(id: "terms", title: NSLocalizedString("terms", comment: ""), image: UIImage(named: "termsOfUseIcon")!),
                Setting(id: "privacy", title: NSLocalizedString("privacyPolicy", comment: ""), image: UIImage(named: "privacyPolicyIcon")!)
        ]),
        SettingsSection(
            title: NSLocalizedString("loveHeader", comment: ""),
            footer: NSLocalizedString("loveFooter", comment: ""),
            settings: [
                Setting(id: "share", title: NSLocalizedString("share", comment: ""), image: UIImage(named: "shareIcon")!),
                Setting(id: "review", title: NSLocalizedString("review", comment: ""), image: UIImage(named: "appStoreIcon")!, isLink: true)
        ])
    ]
}


