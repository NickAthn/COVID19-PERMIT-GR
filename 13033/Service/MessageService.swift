//
//  MessageService.swift
//  13033
//
//  Created by Nikolaos Athanasiou on 14/4/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import MessageUI

class MessageService {
    static func sendMessage(_ vc: UIViewController ,forUser: User, withMovementID: Int) {
        let composeVC = MFMessageComposeViewController()
        // Configure the fields of the interface.
        composeVC.recipients = ["13033"]
        composeVC.body = constructMessage(user: forUser, moveID: withMovementID)

        // Present the view controller modally.
        if MFMessageComposeViewController.canSendText() {
            vc.present(composeVC, animated: true, completion: nil)
        }
    }
    
    static func constructMessage(user: User, moveID: Int) -> String {
        return ["ΜΕΤΑΚΙΝΗΣΗ", String(moveID), user.fullName, user.address].joined(separator: " ")
    }
}

