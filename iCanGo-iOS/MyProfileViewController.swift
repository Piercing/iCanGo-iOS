//
//  MyProfileTabViewController.swift
//  iCanGo-iOS
//
//  Created by MacBook Pro on 5/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {
    
    // MARK: - Init
    convenience init() {
        self.init(nibName: "MyProfileView", bundle: nil)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Methods
    
    func setupUI() -> Void {
        self.title = "My Profile"
        Appearance.customizeAppearance(self.view)
    }
    
}
