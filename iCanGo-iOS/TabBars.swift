////
////  TabBars.swift
////  iCanGo-iOS
////
////  Created by Juan Carlos Merlos Albarracín on 5/7/16.
////  Copyright © 2016 CodeCrafters. All rights reserved.
////
//
//import UIKit
//
//class TabBars: UITabBarController {
//    
//    // MARK: - LifeCycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        delegate = self
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        let itemServicesTabBar = ServicesTabViewController()
//        let itemLocationTabBar =  LocationTabViewController()
//        let itemCreateServiceTabBar =  CreateServiceTabViewController()
//        let itemNotificationsTabBar = NotificationsTabViewController()
//        let itemMyProfileTabBar = MyProfileTabViewController()
//        
//        let iconServicesTabBar = UITabBarItem(
//            title: "Services",
//            image: UIImage(named: "Pin.png"),
//            selectedImage: UIImage(named: "logiCangoVectors.pdf"))
//        
//        let iconLocationTabBar = UITabBarItem(
//            title: "Location",
//            image: UIImage(named: "Pin.png"),
//            selectedImage: UIImage(named: "logiCangoVectors.pdf"))
//        
//        let iconCreateServicesTabBar = UITabBarItem(
//            title: "High Services",
//            image: UIImage(named: "Pin.png"),
//            selectedImage: UIImage(named: "logiCangoVectors.pdf"))
//        
//        let iconNotificationsTabBar = UITabBarItem(
//            title: "Notifications",
//            image: UIImage(named: "Pin.png"),
//            selectedImage: UIImage(named: "logiCangoVectors.pdf"))
//        
//        let iconMyProfileTabBar = UITabBarItem(
//            title: "My Profile",
//            image: UIImage(named: "Pin.png"),
//            selectedImage: UIImage(named: "logiCangoVectors.pdf"))
//        
//        itemServicesTabBar.tabBarItem = iconServicesTabBar
//        itemLocationTabBar.tabBarItem = iconLocationTabBar
//        itemCreateServiceTabBar.tabBarItem = iconCreateServicesTabBar
//        itemNotificationsTabBar.tabBarItem = iconNotificationsTabBar
//        itemMyProfileTabBar.tabBarItem = iconMyProfileTabBar
//        
//        let tabsControllers =
//            [
//                itemServicesTabBar,
//                itemLocationTabBar,
//                itemCreateServiceTabBar,
//                itemNotificationsTabBar,
//                itemMyProfileTabBar
//            ]
//        
//        self.viewControllers = tabsControllers
//        
//    }
//}
//
//// MARK: - Extensions - Delegate Methods
//
////extension TabBars: UITabBarControllerDelegate {
////    
////    func tabBarController(
////        tabBarController: UITabBarController,
////        shouldSelectViewController viewController: UIViewController) -> Bool {
////        
////        print("Should select viewController: \(viewController.title) ?")
////        return true
////    }
////}
//
//
//
//
//
