//
//  NotificationsTabViewController.swift
//  iCanGo-iOS
//
//  Created by MacBook Pro on 5/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {
    
    // MARK: - Properties
    
    let titleView = "Notifications"
    
    // MARK: - Init
    
    convenience init() {
        self.init(nibName: "NotificationsViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = Appearance.setupUI(self.view, title: self.titleView)
        self.title = title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
