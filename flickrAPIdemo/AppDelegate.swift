//
//  AppDelegate.swift
//  flickrAPIdemo
//
//  Created by Stan Liu on 2020/2/25.
//  Copyright © 2020 Stan Liu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.backgroundColor = .white
        
        let nav = UINavigationController(rootViewController: SearchInputViewController())
        self.window!.rootViewController = nav
        self.window!.makeKeyAndVisible()
        
        return true
    }
}

