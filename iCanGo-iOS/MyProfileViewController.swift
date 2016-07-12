//
//  MyProfileTabViewController.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 5/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelLocalizationUser: UILabel!
    @IBOutlet weak var labelPublishedAmount: UILabel!
    @IBOutlet weak var myProfileCollecionView: UICollectionView!
    @IBOutlet weak var segmentControlMyProfile: UISegmentedControl!
    @IBOutlet weak var btnEditLogProfile: UIBarButtonItem!
    
    let cellId = "myProfileCell"
    let nibId = "MyProfileCellView"
    
    // MARK: - Init
    
    convenience init() {
        self.init(nibName: "MyProfileView", bundle: nil)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myProfileCollecionView.delegate = self
        myProfileCollecionView.dataSource = self
        registerCustomCell()
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
    
    // MARK: Cell registration
    
    func registerCustomCell() {
        myProfileCollecionView.registerNib(UINib(nibName: nibId, bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    // MARK: Actions
    
    @IBAction func btnEditMyProfile(sender: AnyObject) {
        // TODO:
        print("Butoom Edit My Profile")
    }
    
    
    @IBAction func segmentControlLogProfile(sender: AnyObject) {
        // TODO:
        if segmentControlMyProfile.selectedSegmentIndex == 0 { 
            print("Segment Published")
        } else if segmentControlMyProfile.selectedSegmentIndex == 1 {
            print("Segment Performed")
        } else {
            print("Segment Searches")
        }
    }
    
    @IBAction func cancelMyProfile(sender: AnyObject) {
        // TODO:
        print("Butoom Cancel My Profile")
    }
}


// MARK: - Extensions - Collection view delegates and datasource

extension MyProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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