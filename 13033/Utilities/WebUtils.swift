//
//  WebUtils.swift
//  13033
//
//  Created by Nikolaos Athanasiou on 15/4/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import UIKit
import SafariServices

class WebUtils {
    static func showSite(_ vc: UIViewController, url: URL) {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let safariVC = SFSafariViewController(url: url, configuration: config)
        vc.present(safariVC, animated: true, completion: nil)
    }
}
