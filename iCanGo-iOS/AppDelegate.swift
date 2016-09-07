//
//  AppDelegate.swift
//  iCanGo-iOS
//
//  Created by Pedro Martin Gomez on 5/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        NSThread.sleepForTimeInterval(1.5);
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        /*
        let session = Session.iCanGoSession()
        let _ = session.getUrlSaS("services", blobName: "test.png")
            
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                
                switch event {
                case let .Next(data):
                    print(data)
                case .Error (let error):
                    print(error)
                    
                default:
                    print("default")
                }
        }
        */
        
        // Navigation Bar Style
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent

        self.window?.rootViewController = StartUpController(nibName: nil, bundle: nil)
        self.window?.makeKeyAndVisible()
        

        
        return true
    }
}




