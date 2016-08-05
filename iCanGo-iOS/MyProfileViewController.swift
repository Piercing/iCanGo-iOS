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
    @IBOutlet weak var labelPerformedAmount: UILabel!
    @IBOutlet weak var myProfileCollecionView: UICollectionView!
    @IBOutlet weak var btnEditLogProfile: UIBarButtonItem!
    @IBOutlet weak var labelService: UILabel!
    @IBOutlet weak var labelSeparator: UILabel!
    @IBOutlet weak var segmentControlMyProfile: SegmentedControlMyProfile!
    @IBOutlet weak var myProfileSearchesTableView: UITableView!
    
    let cellId      = "myProfileCell"
    let nibId       = "MyProfileCellView"
    let titleView   = "My Profile"
    
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
        let title = Appearance.setupUI(self.view, title: self.titleView)
        self.title = title
        
        setUpSegmentControl()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Methods
    
    func setUpSegmentControl() -> Void {
        myProfileSearchesTableView.hidden = true
        labelPublishedAmount.text = "977 published"
        labelSeparator.text = ""
        segmentControlMyProfile.items = ["Published", "Performed", "Searches"]
        segmentControlMyProfile.font = UIFont(name: "Avenir Next", size: 12)
        //segmentControlMyProfile.borderColor = UIColor(white: 1.0, alpha: 0.3)
        segmentControlMyProfile.selectedIndex = 0
        segmentControlMyProfile.addTarget(self, action: #selector(MyProfileViewController.segmentValueChanged(_:)), forControlEvents: .ValueChanged)
    }
    
    func segmentValueChanged(sender: AnyObject?){
        
        // TODO:
        switch segmentControlMyProfile.selectedIndex {
        case 0:
            labelService.text = "Services"
            labelPublishedAmount.text = "977 published"
            labelPerformedAmount.text = ""
            labelSeparator.text = ""
            myProfileSearchesTableView.hidden = true
            myProfileCollecionView.hidden = false
        case 1:
            labelService.text = "Services"
            labelPublishedAmount.text = "79 performed"
            labelPerformedAmount.text = ""
            labelSeparator.text = ""
            myProfileCollecionView.hidden = true
            myProfileSearchesTableView.hidden = true
        case 2:
            labelService.text = "Services"
            labelPublishedAmount.text = "977 published"
            labelPerformedAmount.text = "79 performed"
            labelSeparator.text = "|"
            myProfileCollecionView.hidden = true
            myProfileSearchesTableView.hidden = false
        default:
            break
        }
    }
    //    func setupUI() -> Void {
    //        self.title = "My Profile"
    //        Appearance.customizeAppearance(self.view)
    //    }
    
    
    // MARK: Cell registration
    
    func registerCustomCell() {
        myProfileCollecionView.registerNib(UINib(nibName: nibId, bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    // MARK: Actions
    
    @IBAction func btnEditMyProfile(sender: AnyObject) {
        // TODO:
        print("Tapped buttom Edit My Profile")
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
        Appearance.setupCellUI(cell)
        return cell // TODO: return cell of service
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 170, height: 190)
    }
}