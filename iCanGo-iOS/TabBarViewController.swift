//
//  TabBarViewController.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 5/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var iCanGoTabBarController =  UITabBarController()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func iCangoTabBar() -> UITabBarController {
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
        
        self.iCanGoTabBarController.setViewControllers(
            [
                itemServicesTabBar,
                itemLocationTabBar,
                itemCreateServiceTabBar,
                itemNotificationsTabBar,
                itemMyProfileTabBar
            ],  animated: true)
        
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
