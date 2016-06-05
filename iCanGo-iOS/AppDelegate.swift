//
//  AppDelegate.swift
//  iCanGo-iOS
//
//  Created by Pedro Martin Gomez on 5/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        
        testAlamofire();
        
        let naVC = UINavigationController(nibName: "MainViewController", bundle: nil)
        self.window?.rootViewController = naVC;
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        return true
    }
    
    func testAlamofire() {
        
        Alamofire.request(.GET, "http://www.mocky.io/v2/5753da62120000ab1a4775f2").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                print(swiftyJsonVar);            }
        }
        
    }


}

