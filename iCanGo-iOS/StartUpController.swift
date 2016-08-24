//
//  TabBarViewController.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 5/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class StartUpController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Properties
    var loginVC: LoginViewController?
    var i = 0
    
    
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
        let locationViewController =  LocationViewController()
        let itemCreateServiceTabBar =  AddServiceViewController()
        let itemNotificationsTabBar = NotificationsViewController()
        let myProfileViewController = MyProfileViewController()
        
        let imagesItemsTabBar = ["allServices-withoutBorders-ios-25px.png",
                                 "location-withoutBorders-ios-25px.png",
                                 "addServices-withoutBorders-ios-25px.png",
                                 "notifications-withoutBorders-ios-25px.png",
                                 "myProfile-withoutBorders-ios-25px.png"]
        
        
        let allServicesTabBarItem = UITabBarItem(
            title: "All Services",
            image: UIImage(named: "allServices-borders-ios-25px.png"),
            selectedImage: UIImage(named: "allServices-borders-ios-25px.png")?
                .imageWithRenderingMode(.AlwaysOriginal))
        
        let iconLocationTabBar = UITabBarItem(
            title: "Location",
            image: UIImage(named: "location-borders-ios-25px.png"), // Unselected image
            selectedImage: UIImage(named: "location-borders-ios-25px.png")?
                .imageWithRenderingMode(.AlwaysOriginal)) // Selected image original color
        
        let iconCreateServicesTabBar = UITabBarItem(
            title: "Add Services",
            image: UIImage(named: "addServices-borders-icon-25px.png"),
            selectedImage: UIImage(named: "addServices-borders-icon-25px.png")?
                .imageWithRenderingMode(.AlwaysOriginal))
        
        let iconNotificationsTabBar = UITabBarItem(
            title: "Notifications",
            image: UIImage(named: "notifications-borders-ios-25px.png"),
            selectedImage: UIImage(named: "notifications-borders-ios-25px.png")?
                .imageWithRenderingMode(.AlwaysOriginal))
        
        let myProfileTabBarItem = UITabBarItem(
            title: "My Profile",
            image: UIImage(named: "myProfile-borders-ios-25px.png"),
            selectedImage: UIImage(named: "myProfile-borders-ios-25px.png")?
                .imageWithRenderingMode(.AlwaysOriginal))
        
        
        servicesViewController.tabBarItem = allServicesTabBarItem
        locationViewController.tabBarItem = iconLocationTabBar
        itemCreateServiceTabBar.tabBarItem = iconCreateServicesTabBar
        itemNotificationsTabBar.tabBarItem = iconNotificationsTabBar
        myProfileViewController.tabBarItem = myProfileTabBarItem
        
        let navVCServices = UINavigationController(rootViewController: servicesViewController)
        navVCServices.navigationBarHidden = true
        let navVCLocation = UINavigationController(rootViewController: locationViewController)
        navVCLocation.navigationBarHidden = true
        
        
        let controllers =
            [
                navVCServices,
                navVCLocation,
                itemCreateServiceTabBar,
                itemNotificationsTabBar,
                myProfileViewController
        ]
        
        self.viewControllers = controllers
        
        for item in self.tabBar.items! as [UITabBarItem]{
            item.image = UIImage(named: imagesItemsTabBar[i])?.imageWithRenderingMode(.AlwaysOriginal)
            self.i += 1
        }
        
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
extension StartUpController: ComunicationLoginControllerDelegate {
    
    func back(index: Int) {
        //print("volviendo del tabitem con index: \(index)");
        self.selectedIndex = index
        self.selectedViewController = self.viewControllers![index] as UIViewController
        
    } 
}

