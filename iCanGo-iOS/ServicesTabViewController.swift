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
    @IBOutlet weak var servicesCollectionView: UICollectionView!
    
    var controllerTabBar =  TabBarViewController()
    var isLoaded = false
    
    // MARK: - Init
    
    convenience init() {
        self.init(nibName: "ServicesViewController", bundle: nil)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        servicesCollectionView.registerNib(UINib(nibName: "iCangoServicesCell", bundle: nil), forCellWithReuseIdentifier: "serviceCell")
        servicesCollectionView.delegate = self
        servicesCollectionView.dataSource = self
        
        Appearance.tabBarColor(self.controllerTabBar)
        Appearance.customizeAppearance(self.view)
        
        searchBar.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    
    @IBAction func btnFilter(sender: AnyObject) {
        // TODO: Filter services
        print("Prees button Filter")
    }
    
    @IBAction func btnFavourites(sender: AnyObject) {
        // TODO: check favourites
        print("Prees button Favourites")
    }
}

// MARK: - Extensions - Collection view delegates and datasource

extension ServicesTabViewController: UISearchBarDelegate {
    func textFieldShouldReturn(searchBar: UISearchBar) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
}

extension ServicesTabViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20 // TODO: amount of services received from api
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("serviceCell", forIndexPath: indexPath)
        return cell // TODO: return cell of service
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 170, height: 190)
    }
}




















