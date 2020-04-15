//
//  StoreUtils.swift
//  13033
//
//  Created by Nikolaos Athanasiou on 15/4/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import UIKit
import StoreKit

class StoreUtils {
    static func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()

        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "1508157406") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    static func shareApp(_ vc: UIViewController) {
        let items: [Any] = [
            NSLocalizedString("shareMessage", comment: ""),
            URL(string: "https://www.apple.com")!
        ]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        vc.present(ac, animated: true)
    }

}
