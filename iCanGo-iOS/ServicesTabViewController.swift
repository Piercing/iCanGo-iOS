//
//  ServicesViewController.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 4/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class ServicesTabViewController: UIViewController {
    
    // MARK: - Properties
    var tabBar = TabBars()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Init
    convenience init() {
        self.init(nibName: "ServicesViewController", bundle: nil)
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Services"
        print("item Services loaded")
    
        //searchBar.becomeFirstResponder()
        searchBar.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        searchBar.resignFirstResponder()
        
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

// MARK: - Extensions - Delegates

extension ServicesTabViewController: UISearchBarDelegate {
    func textFieldShouldReturn(searchBar: UISearchBar) -> Bool {
        self.view.endEditing(false)
        return true
    }
}
