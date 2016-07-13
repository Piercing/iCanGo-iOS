//
//  LocationTabViewController.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 5/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var searchBarLocation: UISearchBar!
    
    let titleView = "Location"
    
    // MARK: - Init
    
    convenience init() {
        self.init(nibName: "LocationView", bundle: nil)
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = Appearance.setupUI(self.view, title: self.titleView)
        self.title = title
        
        searchBarLocation.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     // MARK: - Actions
    
    @IBAction func btnFavouritesLocation(sender: AnyObject) {
        // TODO:
        print("Tapp buttom favourites Location")
    }
}

// MARK: - Extensions - Collection view delegates and datasource

extension LocationViewController: UISearchBarDelegate {
    func textFieldShouldReturn(searchBar: UISearchBar) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        searchBarLocation.resignFirstResponder()
    }
}