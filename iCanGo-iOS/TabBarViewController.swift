//
//  TabBarViewController.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 5/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    
    // MARK: - Properties
    var iCanGoTabBarController =  UITabBarController()
    
    var itemServicesTabBar: ServicesTabViewController?
    var itemLocationTabBar:  LocationTabViewController?
    var itemCreateServiceTabBar:  CreateServiceTabViewController?
    var itemNotificationsTabBar: NotificationsTabViewController?
    var itemMyProfileTabBar: MyProfileTabViewController?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    internal func iCangoTabBar() {
        
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
        
        let itemAllServices = UITabBarItem(title: "All Services", image: UIImage(named: "Pin.png"), tag: 0)
        let itemLocation = UITabBarItem(title: "Location", image: UIImage(named: "Pin.png"), tag: 1)
        let itemHighServices = UITabBarItem(title: "High Services", image: UIImage(named: "Pin.png"), tag: 2)
        let itemNotifications = UITabBarItem(title: "Notifications", image: UIImage(named: "Pin.png"), tag: 3)
        let itemMyProfile = UITabBarItem(title: "My Profile", image: UIImage(named: "Pin.png"), tag: 4)
        
        mainTabBarController.tabBarItem = itemAllServices
        mainTabBarController.tabBarItem = itemLocation
        mainTabBarController.tabBarItem = itemHighServices
        mainTabBarController.tabBarItem = itemNotifications
        mainTabBarController.tabBarItem = itemMyProfile
        
    }
}

// MARK: - Extensions - Delegate Methods

extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(
        tabBarController: UITabBarController,
        shouldSelectViewController viewController: UIViewController) -> Bool {
        return true
    }
}
