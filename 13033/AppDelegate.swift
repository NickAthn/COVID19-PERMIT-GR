//
//  AppDelegate.swift
//  13033
//
//  Created by Nikolaos Athanasiou on 14/4/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewController = ViewController()
        
        let navigation = UINavigationController()
        navigation.viewControllers = [viewController]
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = navigation
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

