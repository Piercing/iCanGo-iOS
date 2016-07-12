//
//  AppDelegate.swift
//  iCanGo-iOS
//
//  Created by Pedro Martin Gomez on 5/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // Navigation Bar Style
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        
        self.window?.rootViewController = StartUpController(nibName: nil, bundle: nil)
        self.window?.makeKeyAndVisible()
        return true
    }
}




