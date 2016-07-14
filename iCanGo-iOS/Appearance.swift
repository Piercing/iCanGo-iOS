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
    
    internal static func uicolorFromHex(rgbValue:UInt32)-> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    internal static func tabBarColor(tabBarController: UITabBarController) {
        let color = UIColor(red: 26/255, green: 147/255, blue: 165/255, alpha: 1.0)
        tabBarController.tabBar.barTintColor = color
        tabBarController.tabBar.tintColor = UIColor.whiteColor()
        
    }
    
    internal static func tabBarItemColor() {
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blackColor()], forState:.Selected)
    }
    
    internal static func setupUI(view: UIView, title: String) -> String {
        let title = title
        self.customizeAppearance(view)
        return title
    }
    
    internal static func addDidLayoutSubviews(txtField1: UITextField, txtField2: UITextField, buttom1: UIButton){
        txtField1.layer.cornerRadius = 5
        txtField2.layer.cornerRadius = 5
        buttom1.layer.cornerRadius = 5
    }
    
    internal static func addDidLayoutSubviewsFourButtons(btn1: UIButton, btn2: UIButton, btn3: UIButton, btn4: UIButton){
        btn1.layer.cornerRadius = 5
        btn2.layer.cornerRadius = 5
        btn3.layer.cornerRadius = 5
        btn4.layer.cornerRadius = 5
    }
    
    internal static func setupCellUI (cell: UICollectionViewCell) {
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clearColor().CGColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.grayColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(0, 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(
            roundedRect: cell.bounds,
            cornerRadius: cell.contentView.layer.cornerRadius).CGPath
    }
}



