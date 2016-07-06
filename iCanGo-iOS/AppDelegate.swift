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
    var tabBarController: UITabBarController?
    //var iCanGoTabBarController =  UITabBarController()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // Navigation Bar Style
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        //testAlamofireSwiftyJSON()
        //testHaneke()
        
        //tabBarController.iCangoTabBar()
        
        
        let itemServicesTabBar = ServicesTabViewController()
        let itemLocationTabBar =  LocationTabViewController()
        let itemCreateServiceTabBar =  CreateServiceTabViewController()
        let itemNotificationsTabBar = NotificationsTabViewController()
        let itemMyProfileTabBar = MyProfileTabViewController()
        
        let iconServicesTabBar = UITabBarItem(
            title: "Services",
            image: UIImage(named: "Pin.png"),
            selectedImage: UIImage(named: "logiCangoVectors.pdf"))
        
        let iconLocationTabBar = UITabBarItem(
            title: "Location",
            image: UIImage(named: "Pin.png"),
            selectedImage: UIImage(named: "logiCangoVectors.pdf"))
        
        let iconCreateServicesTabBar = UITabBarItem(
            title: "High Services",
            image: UIImage(named: "Pin.png"),
            selectedImage: UIImage(named: "logiCangoVectors.pdf"))
        
        let iconNotificationsTabBar = UITabBarItem(
            title: "Notifications",
            image: UIImage(named: "Pin.png"),
            selectedImage: UIImage(named: "logiCangoVectors.pdf"))
        
        let iconMyProfileTabBar = UITabBarItem(
            title: "My Profile",
            image: UIImage(named: "Pin.png"),
            selectedImage: UIImage(named: "logiCangoVectors.pdf"))
        
        itemServicesTabBar.tabBarItem = iconServicesTabBar
        itemLocationTabBar.tabBarItem = iconLocationTabBar
        itemCreateServiceTabBar.tabBarItem = iconCreateServicesTabBar
        itemNotificationsTabBar.tabBarItem = iconNotificationsTabBar
        itemMyProfileTabBar.tabBarItem = iconMyProfileTabBar
        
        self.tabBarController = UITabBarController()
        self.tabBarController!.setViewControllers(
            [
                itemServicesTabBar,
                itemLocationTabBar,
                itemCreateServiceTabBar,
                itemNotificationsTabBar,
                itemMyProfileTabBar
            ],  animated: true)


        let loginViewController = LoginViewController(nibName: "LoginView", bundle: nil)
        self.window?.rootViewController = loginViewController
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


