//
//  AppDelegate.swift
//  iCanGo-iOS
//
//  Created by Pedro Martin Gomez on 5/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit
//import Alamofire
//import SwiftyJSON
//import Haneke
//import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var iCanGotabBarController: TabBarViewController?
    var iCanGoTabBarController =  UITabBarController()
    
    var itemServicesTabBar: ServicesTabViewController?
    var itemLocationTabBar:  LocationTabViewController?
    var itemCreateServiceTabBar:  CreateServiceTabViewController?
    var itemNotificationsTabBar: NotificationsTabViewController?
    var itemMyProfileTabBar: MyProfileTabViewController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        
        // Navigation Bar Style
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        //testAlamofireSwiftyJSON()
        //testHaneke()
        
        self.itemServicesTabBar = ServicesTabViewController()
        self.itemLocationTabBar = LocationTabViewController()
        self.itemCreateServiceTabBar = CreateServiceTabViewController()
        self.itemNotificationsTabBar = NotificationsTabViewController()
        self.itemMyProfileTabBar = MyProfileTabViewController()
        
        let mainTabBarController = UITabBarController()
        mainTabBarController.viewControllers =
            [
                itemServicesTabBar!,
                itemLocationTabBar!,
                itemCreateServiceTabBar!,
                itemNotificationsTabBar!,
                itemMyProfileTabBar!
        ]
        
        let itemAllServices = UITabBarItem(title: "All Services", image: UIImage(named: "badge-apple.pdf"), tag: 0)
        let itemLocation = UITabBarItem(title: "Location", image: UIImage(named: "badge-apple.pdf"), tag: 1)
        let itemHighServices = UITabBarItem(title: "High Services", image: UIImage(named: "badge-apple.pdf")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), tag: 2)
        let itemNotifications = UITabBarItem(title: "Notifications", image: UIImage(named: "badge-apple.pdf")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), tag: 3)
        let itemMyProfile = UITabBarItem(title: "My Profile", image: UIImage(named: "badge-apple.pdf")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), tag: 4)
        
        mainTabBarController.tabBarItem = itemAllServices
        mainTabBarController.tabBarItem = itemLocation
        mainTabBarController.tabBarItem = itemHighServices
        mainTabBarController.tabBarItem = itemNotifications
        mainTabBarController.tabBarItem = itemMyProfile
        
        Appearance.tabBarItemColor()
        Appearance.tabBarColor(mainTabBarController)
             
        self.window?.rootViewController = mainTabBarController
        self.window?.makeKeyAndVisible()
        return true
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


