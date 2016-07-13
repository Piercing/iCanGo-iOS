//
//  CreateServiceTabViewController.swift
//  iCanGo-iOS
//
//  Created by MacBook Pro on 5/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class HighServiceViewController: UIViewController {
    
    // MARK: - Init
    convenience init() {
        self.init(nibName: "HighServiceView", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "High Services"
        
        Appearance.customizeAppearance(self.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addService(sender: AnyObject) {
        print("Tapped buttom add service")
    }
    @IBAction func cancelHighService(sender: AnyObject) {
        print("Tapped buttom cancel High service")
    }
}
