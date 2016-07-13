//
//  TabBarViewController.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 5/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class StartUpController: UITabBarController, UITabBarControllerDelegate {
    
    var loginVC: LoginViewController?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Internal Methods
    
    func setup() {
        
        self.delegate = self
        
        let servicesViewController = ServicesViewController()
        let itemLocationTabBar =  LocationViewController()
        let itemCreateServiceTabBar =  HighServiceViewController()
        let itemNotificationsTabBar = NotificationsViewController()
        let myProfileViewController = MyProfileViewController()
        
        let allServicesTabBarItem = UITabBarItem(
            title: "All Services",
            image: UIImage(named: "pin-1.png"),
            selectedImage: UIImage(named: "pin-1.png")?
                .imageWithRenderingMode(.AlwaysTemplate))
        
        let iconLocationTabBar = UITabBarItem(
            title: "Location",
            image: UIImage(named: "pin-1.png"), // Unselected image
            selectedImage: UIImage(named: "pin-1.png")?
                .imageWithRenderingMode(.AlwaysTemplate)) // Selected image original color
        
        let iconCreateServicesTabBar = UITabBarItem(
            title: "High Services",
            image: UIImage(named: "pin-1.png"),
            selectedImage: UIImage(named: "pin-1.png")?
                .imageWithRenderingMode(.AlwaysTemplate))
        
        let iconNotificationsTabBar = UITabBarItem(
            title: "Notifications",
            image: UIImage(named: "pin-1.png"),
            selectedImage: UIImage(named: "pin-1.png")?
                .imageWithRenderingMode(.AlwaysTemplate))
        
        let myProfileTabBarItem = UITabBarItem(
            title: "My Profile",
            image: UIImage(named: "pin-1.png"),
            selectedImage: UIImage(named: "pin-1.png")?
                .imageWithRenderingMode(.AlwaysTemplate))
        
        servicesViewController.tabBarItem = allServicesTabBarItem
        itemLocationTabBar.tabBarItem = iconLocationTabBar
        itemCreateServiceTabBar.tabBarItem = iconCreateServicesTabBar
        itemNotificationsTabBar.tabBarItem = iconNotificationsTabBar
        myProfileViewController.tabBarItem = myProfileTabBarItem
        
        let navVC = UINavigationController(rootViewController: servicesViewController)
        navVC.navigationBarHidden = true
        let controllers =
            [
                navVC,
                itemLocationTabBar,
                itemCreateServiceTabBar,
                itemNotificationsTabBar,
                myProfileViewController
            ]
        
        self.viewControllers = controllers
        
        Appearance.tabBarItemColor()
        Appearance.tabBarColor(self)
        
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if viewController is MyProfileViewController {
            
            if !isUserloged() {
                
                loginVC = LoginViewController(nibName: "LoginView", bundle: nil)
                loginVC!.delegate = self
                loginVC!.selectedTabItemIndex = tabBarController.selectedIndex
                
                showModal(self, calledContainer: loginVC!)
                return false;
            }
        }
        
        return true
    }
}

// MARK: - Extensions - Delegate Methods

//extension StartUp: UITabBarControllerDelegate {
//    
//    func tabBarController(
//        tabBarController: UITabBarController,
//        shouldSelectViewController viewController: UIViewController) -> Bool {
//        
//        print("Should select viewController: \(viewController.title) ?")
//        return true
//    }
//}

extension StartUpController: ComunicationLoginControllerDelegate {
    
    func back(index: Int) {
        //print("volviendo del tabitem con index: \(index)");
        self.selectedIndex = index
        self.selectedViewController = self.viewControllers![index] as UIViewController
        
    } 
}

