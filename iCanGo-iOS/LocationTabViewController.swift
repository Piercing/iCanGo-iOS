//
//  LocationTabViewController.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 5/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class LocationTabViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var searchBarLocation: UISearchBar!
    
    // MARK: - Init
    
    convenience init() {
        self.init(nibName: "LocationTabViewController", bundle: nil)
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Location"
        
        Appearance.customizeAppearance(self.view)
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

extension LocationTabViewController: UISearchBarDelegate {
    func textFieldShouldReturn(searchBar: UISearchBar) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        searchBarLocation.resignFirstResponder()
    }
}