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
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
   
        testGetServices()
        
        // Navigation Bar Style
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
             
        self.window?.rootViewController = StartUpController(nibName: nil, bundle: nil)
        self.window?.makeKeyAndVisible()
        return true
    }
    
    
    func testGetServices() {
        
        let session = Session.iCanGoSession()
        let _ = session.getServices("", page: 1, rows: 20)
            
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                
                switch event {
                case let .Next(services):
                    for service in services {
                        print(service)
                    }
                    
                case .Error(let error):
                    
                    switch error {
                    case SessionError.APIErrorNoData:
                        print("No existen datos: \(error)")
                    default:
                        print(error)
                    }
                    
                default:
                    break
                }
        }
    }
    
}


