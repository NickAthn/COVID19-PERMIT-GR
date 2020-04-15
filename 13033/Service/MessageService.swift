//
//  MessageService.swift
//  13033
//
//  Created by Nikolaos Athanasiou on 14/4/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import MessageUI

enum MessagingError: Error {
    case cantSendMessage
}

class MessageService: NSObject  {
    var delegate: MFMessageComposeViewControllerDelegate!
    
    override init() {
        super.init()
        delegate = self
    }
    
    func sendMessage(_ vc: UIViewController ,forUser: User, withMovementID: Int) throws {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self

        // Configure the fields of the interface.
        composeVC.recipients = ["13033"]
        composeVC.body = MessageService.constructMessage(user: forUser, moveID: withMovementID)

        // Present the view controller modally.
        if MFMessageComposeViewController.canSendText() {
            vc.navigationController?.present(composeVC, animated: true, completion: nil)
        } else {
            throw MessagingError.cantSendMessage
        }
    }
    
    static func constructMessage(user: User, moveID: Int) -> String {
        return [String(moveID), user.fullName, user.address].joined(separator: " ")
    }
}

extension MessageService: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}
