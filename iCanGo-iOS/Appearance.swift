//
//  Appereance.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 7/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class Appearance: UIView {
    
    internal static func customizeAppearance(view: UIView) {
        let statusBarColor = UIColor(red: 26/255, green: 147/255, blue: 165/255, alpha: 1)
        let colorStatusBar: UIView = UIView(frame: CGRectMake(0, 0,view.frame.size.width, 20))
        colorStatusBar.backgroundColor = statusBarColor
        view.addSubview(colorStatusBar)
    }
    
    internal static func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    internal static func tabBarColor(tabBarController: UITabBarController) {
        let color = UIColor(red: 32/255, green: 155/255, blue: 177/255, alpha: 1.0)
        tabBarController.tabBar.barTintColor = color
        tabBarController.tabBar.tintColor = UIColor.whiteColor()
    }
}
