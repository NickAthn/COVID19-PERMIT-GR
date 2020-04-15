//
//  AppDelegate.swift
//  13033
//
//  Created by Nikolaos Athanasiou on 14/4/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import UIKit
import Disk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewController: UIViewController!

        do {
            // Check if user exists
            try Disk.retrieve("user.json", from: .applicationSupport, as: User.self)
            // if yes go to
            viewController = MovementViewController()
        } catch {
            // if user doesnt exist ask for new
            viewController = UserInfoViewController()
        }

        let navigation = UINavigationController()
        navigation.viewControllers = [viewController]
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = navigation
        self.window?.makeKeyAndVisible()
        
        self.window?.tintColor = ColorScheme().theme
        return true
    }
}

