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
    let cellId = "serviceCell"
    let nibId = "ServiceCellView"
    let userDefaultiCanGo = "userDefaultiCanGo"
    
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
    private var segmentSelected: UInt = 0
    private var requestDataInProgress: Bool = false
    private var currentPagePublished: UInt = 1
    private var currentPageAttended: UInt = 1
    private var servicesPublished: [Service]?
    private var servicesAttended: [Service]?
    private var totalServicesPublished: Int = 0
    private var totalServicesAttended: Int = 0
    private var isNeededRefreshServicesPublished: Bool = false
    private var isNeededRefreshServicesAttended: Bool = false
    
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
        self.servicesPublished = [Service]()
        self.servicesAttended = [Service]()
        
        // Setup UI.
        setupViews()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Setup User.
        setupUser()

        self.user = loadUserAuthInfo()
        
        // Show data user.
        showDataUser()
        
        // Get services from API.
        segmentSelected == 0 ? getServicesFromApi(self.currentPagePublished) : getServicesFromApi(self.currentPageAttended)
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
            segmentSelected = 0
            currentPagePublished = 1
            servicesPublished?.removeAll()
            getServicesFromApi(self.currentPagePublished)
            isNeededRefreshServicesAttended = true
        } else {
            segmentSelected = 1
            currentPageAttended = 1
            servicesAttended?.removeAll()
            getServicesFromApi(self.currentPageAttended)
            isNeededRefreshServicesPublished = true
        }
    }
    
    
    // MARK: Cell registration
    func registerCustomCell() {
        myProfileCollecionView.registerNib(UINib(nibName: nibId, bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    
    // MARK: Actions
    @IBAction func btnEditMyProfile(sender: AnyObject) {
        
        if user.status != StatusUser.active.rawValue {
            
            showAlert(userProfileTitle, message: userProfileNotAllowEdit, controller: self)
        } else {
            let myProfileEditViewController = MyProfileEditViewController(user: user)
            myProfileEditViewController.delegate = self
            let slideDownUpTransition = CATransition()
            slideDownUpTransition.duration = 0.3
            slideDownUpTransition.type = kCATransitionMoveIn
            slideDownUpTransition.subtype = kCATransitionFromTop
            self.navigationController?.view.layer.addAnimation(slideDownUpTransition, forKey: kCATransition)
            self.navigationController?.pushViewController(myProfileEditViewController, animated: false)
        }
    }
    
    
    // MARK: Private Methods
    private func setupViews() {
        
        segmentControlMyProfile.items = [publishedText, attendedText]
        segmentControlMyProfile.font = UIFont(name: avenirNextFont, size: 12)
        segmentControlMyProfile.selectedIndex = 0
        segmentControlMyProfile.addTarget(self, action: #selector(MyProfileViewController.segmentValueChanged(_:)), forControlEvents: .ValueChanged)
        myProfileCollecionView.fadeOut(duration: 0.0)
    }
    
    private func setupUser() {
        
        labelUserName.text = ""
        labelEmailUser.text = ""
        labelPublishedAttendedText.text = ""
        labelPublishedAttendedAmount.text = ""
        labelService.text = ""
        labelSeparator.text = ""
        
        // Initialize variables.
        self.servicesPublished?.removeAll()
        self.servicesAttended?.removeAll()
        currentPagePublished = 1
        currentPageAttended = 1
        totalServicesPublished = 0
        totalServicesAttended = 0
    }
    
    private func showDataUser() {
        
        labelUserName.text = "\(user.firstName) \(user.lastName)"
        labelEmailUser.text = user.email
        userPhotoView.image = UIImage.init(named: userDefaultiCanGo)
        if user.photoUrl != nil {
            loadImageBase64(user.photoUrl!, control: userPhotoView, withAnimation: false)
        } 
        
        labelService.text = servicesText
        if (segmentSelected == 0) {
            labelPublishedAttendedText.text = publishedText
        } else {
            labelPublishedAttendedText.text = attendedText
        }
    }
    
    private func getServicesFromApi(page: UInt) -> Void {
        
        if !isConnectedToNetwork() {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
            return
        }
        
        if requestDataInProgress {
            showAlert(userProfileTitle, message: apiConnectionNoPossible, controller: self)
            return
        }
        
        requestDataInProgress = true
        alertView.displayView(view, withTitle: pleaseWait)
        
        let session = Session.iCanGoSession()
        let _ = session.getUserServicesByType(user.id, type: segmentSelected, page: page, rows: rowsPerPage)
            
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                
                self!.alertView.hideView()
                self?.requestDataInProgress = false
                
                switch event {
                case let .Next(services):
                    if services.count > 0 {
                        if (self!.segmentSelected == 0) {
                            self?.servicesPublished?.appendContentsOf(services)
                            self?.myProfileCollecionView.reloadData()
                            self?.myProfileCollecionView.fadeIn(duration: 0.3)
                            self?.currentPagePublished += 1
                            self?.totalServicesPublished = totalRows
                        } else {
                            self?.servicesAttended?.appendContentsOf(services)
                            self?.myProfileCollecionView.reloadData()
                            self?.myProfileCollecionView.fadeIn(duration: 0.3)
                            self?.currentPageAttended += 1
                            self?.totalServicesAttended = totalRows
                        }
                        self?.labelPublishedAttendedAmount.text = String(totalRows)
                    } else {
                        self?.myProfileCollecionView.reloadData()
                    }
                    
                case .Error (let error):
                    showAlert(userProfileTitle, message: serviceGetServicesKO, controller: self!)
                    print(error)
                    
                default:
                    break
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
            labelPublishedAttendedAmount.text = totalServicesPublished == 0 ? "" : String(totalServicesPublished)
            if servicesPublished?.count == 0 || isNeededRefreshServicesPublished {
                currentPagePublished = 1
                getServicesFromApi(currentPagePublished)
                isNeededRefreshServicesPublished = false
            } else {
                myProfileCollecionView.reloadData()
            }
        case 1:
            segmentSelected = 1
            labelPublishedAttendedText.text = attendedText
            labelPublishedAttendedAmount.text = totalServicesAttended == 0 ? "" : String(totalServicesAttended)
            if servicesAttended?.count == 0 || isNeededRefreshServicesAttended {
                currentPageAttended = 1
                getServicesFromApi(currentPageAttended)
                isNeededRefreshServicesAttended = false
            } else {
                myProfileCollecionView.reloadData()
            }
        default:
            break
        }
    }
}


// MARK: - Extensions - Collection view delegates and datasource
extension MyProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let index = segmentSelected == 0 ? indexPath.row % servicesPublished!.count : indexPath.row % servicesAttended!.count
        showModal(index)
    }
    
    func showModal(index: Int) {
        
        let detailServiceViewController = DetailServiceViewController(service: segmentSelected == 0 ? servicesPublished![index] : servicesAttended![index])
        self.navigationController?.pushViewController(detailServiceViewController, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (segmentSelected == 0 ? self.servicesPublished?.count : self.servicesAttended?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! ServiceCell
        Appearance.setupCellUI(cell)
        cell.service = segmentSelected == 0 ? servicesPublished![indexPath.row % servicesPublished!.count] :
            servicesAttended![indexPath.row % servicesAttended!.count]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake((UIScreen.mainScreen().bounds.width)/2.2, 190)
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        if totalRows == (segmentSelected == 0 ? self.servicesPublished?.count : self.servicesAttended?.count) {
            return
        }
        
        if (segmentSelected == 0) {
            if (indexPath.row == (self.servicesPublished?.count)! - 2) {
                let servicesInList = (self.servicesPublished?.count)! % Int(rowsPerPage)
                if (servicesInList == 0) {
                    getServicesFromApi(self.currentPagePublished)
                }
            }
            
        } else {
            if (indexPath.row == (self.servicesAttended?.count)! - 2) {
                let servicesInList = (self.servicesAttended?.count)! % Int(rowsPerPage)
                if (servicesInList == 0) {
                    getServicesFromApi(self.currentPageAttended)
                }
            }
        }
    }
}


extension MyProfileViewController: MyProfileEditControllerDelegate {
    
    func back(user: User, endSession: Bool) {
        
        if endSession {
            self.tabBarController!.selectedIndex = 0
        } else {
            self.user = user
        }
    }
}




