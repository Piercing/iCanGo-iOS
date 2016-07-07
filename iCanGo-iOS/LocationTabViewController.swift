//
//  LocationTabViewController.swift
//  iCanGo-iOS
//
//  Created by MacBook Pro on 5/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class LocationTabViewController: UIViewController {
    
    // MARK: - Init
    convenience init() {
        self.init(nibName: "LocationTabViewController", bundle: nil)
    }
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Location"
        
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
