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
import Haneke

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // Navigation Bar Color
        //UINavigationBar.appearance().tintColor = UIColor(red: 30/255, green: 170/255, blue: 191/255, alpha: 1)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        //testAlamofireSwiftyJSON()
        //testHaneke()
        testGetServices()
        
        let naVC = UINavigationController(nibName: "MainViewController", bundle: nil)
        self.window?.rootViewController = naVC;
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        return true
    }
    
    func testGetServices() {
        
        let session = Session.iCanGoSession()
        session.getServices("5753da62120000ab1a4775f2").subscribeNext { services in
            print(services)
        }
    }
    
    /*
    func testAlamofireSwiftyJSON() {
        
        Alamofire.request(.GET, "http://www.mocky.io/v2/5753da62120000ab1a4775f2").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                print(swiftyJsonVar);
            }
        }
    }
    */
    
    /*
    func testHaneke() {
        
        let cache = Shared.imageCache
        let URL = NSURL(string: "http://urbinavolant.com/alberto/wp-content/uploads/2008/11/avi.jpg")!
        let fetcher = NetworkFetcher<UIImage>(URL: URL)
        cache.fetch(fetcher: fetcher).onSuccess { image in
            // Do something with image
            print("image loaded")
        }
        print("end");
    }
    */
}

