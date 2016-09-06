//
//  MyProfileTabViewController.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 5/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit
import RxSwift

class MyProfileViewController: UIViewController {
    
    // MARK: - Constants
    let cellId      = "myProfileCell"
    let nibId       = "MyProfileCellView"
    
    
    // MARK: - Properties
    @IBOutlet weak var userPhotoView: CircularImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelEmailUser: UILabel!
    @IBOutlet weak var myProfileCollecionView: UICollectionView!
    @IBOutlet weak var btnEditLogProfile: UIBarButtonItem!
    @IBOutlet weak var labelService: UILabel!
    @IBOutlet weak var labelSeparator: UILabel!
    @IBOutlet weak var labelPublishedAttendedText: UILabel!
    @IBOutlet weak var labelPublishedAttendedAmount: UILabel!
    @IBOutlet weak var segmentControlMyProfile: SegmentedControlMyProfile!
    
    private var user: User!
    private var requestDataInProgress: Bool = false
    private var currentPage: UInt = 1
    private var services: [Service]?
    private var segmentSelected = 0

    lazy var alertView: AlertView = {
        let alertView = AlertView()
        return alertView
    }()

    
    // MARK: - Init
    convenience init() {
        self.init(nibName: "MyProfileView", bundle: nil)
        
        // Add as observer
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ServicesViewController.refreshServiceList(_:)),
                                                         name: notificationKeyServicesChange,
                                                         object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: notificationKeyServicesChange, object: nil)
    }

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register Nib Cells.
        registerCustomCell()
        
        self.title = Appearance.setupUI(self.view, title: myProfileTitleVC)
        
        myProfileCollecionView.delegate = self
        myProfileCollecionView.dataSource = self
        
        // Initialize variables.
        self.services = [Service]()

        // Setup UI.
        setupViews()
        self.user = loadUserAuthInfo()
        
        // Show data user.
        showDataUser()
        
        // Get services from API.
        getPublishedServicesFromApi(self.currentPage)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isConnectedToNetwork() {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Notification Methods
    func refreshServiceList(notification: NSNotification) {
        
        if !self.isViewLoaded() {
            return
        }
        
        if segmentSelected == 0 {
            currentPage = 1
            services?.removeAll()
            myProfileCollecionView.reloadData()
            getPublishedServicesFromApi(self.currentPage)
            return
        }
    }

    
    // MARK: Cell registration
    func registerCustomCell() {
        myProfileCollecionView.registerNib(UINib(nibName: nibId, bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    
    // MARK: Actions
    @IBAction func btnEditMyProfile(sender: AnyObject) {
        // TODO:
        print("Tapped buttom Edit My Profile")
    }
    
    
    // MARK: Private Methods
    private func setupViews() {
        
        labelUserName.text = ""
        labelEmailUser.text = ""
        labelPublishedAttendedText.text = ""
        labelPublishedAttendedAmount.text = ""
        labelService.text = ""
        labelSeparator.text = ""
    }

    private func showDataUser() {
        
        labelUserName.text = "\(user.firstName) \(user.lastName)"
        labelEmailUser.text = user.email
        if user.photoURL != nil {
            loadImage(user.photoURL!, imageView: userPhotoView, withAnimation: false)
        }

        labelService.text = servicesText
        labelPublishedAttendedText.text = publishedText
        labelPublishedAttendedAmount.text = String(user.numPublishedServices)
        labelSeparator.text = ""
        
        segmentControlMyProfile.items = [publishedText, attendedText]
        segmentControlMyProfile.font = UIFont(name: avenirNextFont, size: 12)
        segmentControlMyProfile.selectedIndex = 0
        segmentControlMyProfile.addTarget(self, action: #selector(MyProfileViewController.segmentValueChanged(_:)), forControlEvents: .ValueChanged)
        
        myProfileCollecionView.fadeOut(duration: 0.0)
    }

    private func getPublishedServicesFromApi(page: UInt) -> Void {
        
        if !isConnectedToNetwork() {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
            return
        }
        
        if requestDataInProgress {
            return
        }
        
        requestDataInProgress = true        
        alertView.displayView(view, withTitle: pleaseWait)

        let session = Session.iCanGoSession()
        let _ = session.getUserServices(user.id, page: page, rows: rowsPerPage)
            
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                
                self!.alertView.hideView()
                
                switch event {
                case let .Next(services):
                    self?.requestDataInProgress = false
                    if services.count > 0 {
                        self?.services?.appendContentsOf(services)
                        self?.myProfileCollecionView.reloadData()
                        self?.myProfileCollecionView.fadeIn(duration: 0.3)
                        self?.currentPage += 1
                    }
                    
                case .Error (let error):
                    self?.requestDataInProgress = false
                    print(error)
                    
                default:
                    self?.requestDataInProgress = false
                }
        }
    }

    
    // MARK: Methods
    func segmentValueChanged(sender: AnyObject?){
        
        labelPublishedAttendedText.text = ""
        labelPublishedAttendedAmount.text = ""

        switch segmentControlMyProfile.selectedIndex {
        case 0:
            segmentSelected = 0
            labelPublishedAttendedText.text = publishedText
            labelPublishedAttendedAmount.text = String(user.numPublishedServices)
        case 1:
            segmentSelected = 1
            labelPublishedAttendedText.text = attendedText
            labelPublishedAttendedAmount.text = String(user.numAttendedServices)
        default:
            break
        }
    }
}


// MARK: - Extensions - Collection view delegates and datasource
extension MyProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let index = indexPath.row % services!.count
        showModal(index)
    }
    
    func showModal(index: Int) {
        
        let detailServiceViewController = DetailServiceViewController(service: services![index])
        self.navigationController?.pushViewController(detailServiceViewController, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.services?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! MyProfileCell
        Appearance.setupCellUI(cell)
        cell.service = services![indexPath.row % services!.count]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // return CGSize(width: 170, height: 190)
        return CGSizeMake((UIScreen.mainScreen().bounds.width)/2.2, 190)
        
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        if totalRows == self.services?.count {
            return
        }
        
        if (indexPath.row == (self.services?.count)! - 2) {
            
            let servicesInList = (self.services?.count)! % Int(rowsPerPage)
            if (servicesInList == 0) {
                getPublishedServicesFromApi(self.currentPage)
            }
        }
    }
}





