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
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var favouritesBtn: UIButton!
    
    var isLoaded = false
    
    // MARK: - Init
    convenience init() {
        self.init(nibName: "ServicesViewController", bundle: nil)
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Appearance.customizeAppearance(self.view)
        
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
    
    @IBAction func btnFilter(sender: AnyObject) {
        print("Prees button Filter")
    }
    
    @IBAction func btnFavourites(sender: AnyObject) {
        print("Prees button Favourites")
    }
}

// MARK: - Extensions - Delegates

extension ServicesTabViewController: UISearchBarDelegate {
    func textFieldShouldReturn(searchBar: UISearchBar) -> Bool {
        self.view.endEditing(false)
        return true
    }
}
