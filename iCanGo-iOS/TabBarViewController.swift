//
//  TabBarViewController.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 5/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    // MARK: - Internal Methods
    
    internal static func iCangoTabBar() -> UITabBarController {
        
        let iCanGoTabBarController =  UITabBarController()
        
        let itemServicesTabBar = ServicesTabViewController()
        let itemLocationTabBar =  LocationTabViewController()
        let itemCreateServiceTabBar =  CreateServiceTabViewController()
        let itemNotificationsTabBar = NotificationsTabViewController()
        let itemMyProfileTabBar = MyProfileTabViewController()
        
        let iconServicesTabBar = UITabBarItem(
            title: "Services",
            image: UIImage(named: "pin-1.png"),
            selectedImage: UIImage(named: "logiCangoVectors.pdf"))
        
        let iconLocationTabBar = UITabBarItem(
            title: "Location",
            image: UIImage(named: "pin-1.png"),
            selectedImage: UIImage(named: "logiCangoVectors.pdf"))
        
        let iconCreateServicesTabBar = UITabBarItem(
            title: "High Services",
            image: UIImage(named: "pin-1.png"),
            selectedImage: UIImage(named: "logiCangoVectors.pdf"))
        
        let iconNotificationsTabBar = UITabBarItem(
            title: "Notifications",
            image: UIImage(named: "pin-1.png"),
            selectedImage: UIImage(named: "logiCangoVectors.pdf"))
        
        let iconMyProfileTabBar = UITabBarItem(
            title: "My Profile",
            image: UIImage(named: "pin-1.png"),
            selectedImage: UIImage(named: "logiCangoVectors.pdf"))
        
        itemServicesTabBar.tabBarItem = iconServicesTabBar
        itemLocationTabBar.tabBarItem = iconLocationTabBar
        itemCreateServiceTabBar.tabBarItem = iconCreateServicesTabBar
        itemNotificationsTabBar.tabBarItem = iconNotificationsTabBar
        itemMyProfileTabBar.tabBarItem = iconMyProfileTabBar
        
        let controllers =
            [
                itemServicesTabBar,
                itemLocationTabBar,
                itemCreateServiceTabBar,
                itemNotificationsTabBar,
                itemMyProfileTabBar
            ]
        
        iCanGoTabBarController.viewControllers = controllers
        
        Appearance.tabBarItemColor()
        Appearance.tabBarColor(iCanGoTabBarController)
        return iCanGoTabBarController
        
    }
}

// MARK: - Extensions - Delegate Methods

extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(
        tabBarController: UITabBarController,
        shouldSelectViewController viewController: UIViewController) -> Bool {
        
        print("Should select viewController: \(viewController.title) ?")
        return true
    }
}
