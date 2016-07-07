//
//  NotificationsTabViewController.swift
//  iCanGo-iOS
//
//  Created by MacBook Pro on 5/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class NotificationsTabViewController: UIViewController {
    
    // MARK: - Init
    convenience init() {
        self.init(nibName: "NotificationsTabViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Notifications"
        
        Appearance.customizeAppearance(self.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
