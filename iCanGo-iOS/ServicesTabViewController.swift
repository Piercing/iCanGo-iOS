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
}

// MARK: - Extensions - Delegates

extension ServicesTabViewController: UISearchBarDelegate {
    func textFieldShouldReturn(searchBar: UISearchBar) -> Bool {
        self.view.endEditing(false)
        return true
    }
}
