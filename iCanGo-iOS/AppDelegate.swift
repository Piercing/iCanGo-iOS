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
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        //testAlamofireSwiftyJSON()
        //testHaneke()
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewControllerWithIdentifier("Login") as UIViewController
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
        
        return true
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

