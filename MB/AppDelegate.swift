//
//  AppDelegate.swift
//  MB
//
//  Created by Max Bolotov on 05.08.2020.
//  Copyright © 2020 Max Bolotov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow()
        self.window?.rootViewController = ApplicationStoryboard.main.initialViewController()
        self.window?.makeKeyAndVisible()

        return true
    }

}

