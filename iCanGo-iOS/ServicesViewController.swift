//
//  ServicesViewController.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 4/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class ServicesViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var favouritesBtn: UIButton!
    @IBOutlet weak var servicesCollectionView: UICollectionView!
    
    var isLoaded = false
    let cellId = "serviceCell"
    
    // MARK: - Init
    
    convenience init() {
        self.init(nibName: "ServicesView", bundle: nil)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCustomCell()
        servicesCollectionView.delegate = self
        servicesCollectionView.dataSource = self
        setupUI()
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
    
    // MARK: Methods
    
    // MARK: Methods
    
    func setupUI() -> Void {
        self.title = "All Services"
        Appearance.tabBarColor(self.tabBarController!)
        Appearance.customizeAppearance(self.view)
    }
    
    // MARK: Cell registration
    
    func registerCustomCell() {
        servicesCollectionView.registerNib(UINib(nibName: "ServiceCellView", bundle: nil), forCellWithReuseIdentifier: cellId)
    }
}

// MARK: - Extensions - Collection view delegates and datasource

extension ServicesViewController: UISearchBarDelegate {
    func textFieldShouldReturn(searchBar: UISearchBar) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
}

extension ServicesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20 // TODO: amount of services received from api
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath)
        return cell // TODO: return cell of service
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 170, height: 190)
    }
}




















