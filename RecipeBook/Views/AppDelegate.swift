//
//  AppDelegate.swift
//  RecipeBook
//
//  Created by David Farcas on 09.08.2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

        var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
            sleep(2)
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = NameScreenViewController()
            window.makeKeyAndVisible()

            self.window = window
            return true
        }


}
