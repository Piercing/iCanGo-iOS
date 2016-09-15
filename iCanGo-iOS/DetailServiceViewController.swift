//
//  DetailService.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 12/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit
import MapKit
import RxSwift

class DetailServiceViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var nameServiceDetailService: UILabel!
    @IBOutlet weak var contactPersonDetailServiceBtn: UIButton!
    //@IBOutlet weak var clearServiceDetailBtn: UIButton!
    @IBOutlet weak var nameUserDetailService: UILabel!
    @IBOutlet weak var dataDetailService: UILabel!
    @IBOutlet weak var photoUserDetailService: CircularImageView!
    @IBOutlet weak var publishedDetailService: UILabel!
    @IBOutlet weak var caretedDetailsService: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var priceDetailService: UILabel!
    @IBOutlet weak var descriptionDetatilService: UITextView!
    @IBOutlet weak var publishedLabel: UILabel!
    @IBOutlet weak var attendedLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressText: UITextView!
    @IBOutlet weak var imgDetailService01: UIImageView!
    @IBOutlet weak var imgDetailService02: UIImageView!
    @IBOutlet weak var imgDetailService03: UIImageView!
    @IBOutlet weak var imgDetailService04: UIImageView!
    @IBOutlet weak var clearServiceDetailBtnTrash: UIBarButtonItem!
    
    var popUpVIewController: PopUpImagesViewController?
    var selectImage =  UIImageView()
    private var requestDataInProgress: Bool = false
    private var service: Service!
    private var user: User!

    lazy var alertView: AlertView = {
        let alertView = AlertView()
        return alertView
    }()


    // MARK: - Constant.
    let conversationNameImage = "conversation03"
    let userDefaultiCanGoNameImage = "userDefaultiCanGo"
    let emptyCameraNameImage = "iConCamera+"
    let popUpImagesNameImage = "PopUpImagesView"
    let serviceId = "serviceId"
    
    
    // MARK: - Init
    convenience init(service: Service) {
        
        self.init(nibName: "DetailServiceView", bundle: nil)
        
        // Initialize variables.
        self.service = service
    }
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = Appearance.setupUI(self.view, title: detailServiceTitleVC)
        
        // Initialize data en view.
        setupViews()
        
        // Get data from API.
        loadService(service.id)
        
        // Load default images and textLabel.
        contactPersonDetailServiceBtn.setImage(UIImage.init(named: conversationNameImage), forState: UIControlState.Normal)
        photoUserDetailService.image = UIImage.init(named: userDefaultiCanGoNameImage)
        imgDetailService01.image = UIImage.init(named: emptyCameraNameImage)
        imgDetailService02.image = UIImage.init(named: emptyCameraNameImage)
        imgDetailService03.image = UIImage.init(named: emptyCameraNameImage)
        imgDetailService04.image = UIImage.init(named: emptyCameraNameImage)
        publishedLabel.text = publishedText
        attendedLabel.text = attendedText
        
        // Show data service.
        showDataService()
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
    }
    
    
    // MARK: - Actions
    @IBAction func btnContactPersonDetailService(sender: AnyObject) {
        
        let okAction = UIAlertAction(title: ok, style: .Default, handler:{ (action: UIAlertAction!) in
            self.responseServiceAPI(self.service.id, status: StatusService.requestedToAttend.rawValue, idUserResponse: self.user.id)
        })
        let cancelAction = UIAlertAction(title: cancel, style: .Cancel, handler: nil)
        let actions = [okAction, cancelAction]
        showAlertWithActions(serviceRequestedToAttendTitle, message: serviceRequestedToAttendConfirmationMessage, controller: self, actions: actions)
    }
    
    @IBAction func btnDeleteServiceDetail(sender: AnyObject) {
        
        let okAction = UIAlertAction(title: ok, style: .Default, handler:{ (action: UIAlertAction!) in
            self.deteteServiceAPI(self.service.id)
        })
        let cancelAction = UIAlertAction(title: cancel, style: .Cancel, handler: nil)
        let actions = [okAction, cancelAction]
        showAlertWithActions(serviceDeleteTitle, message: serviceDeleteConfirmationMessage, controller: self, actions: actions)
    }
    
    @IBAction func btnSharedDetatilService(sender: AnyObject) {
        
        let nameServiceToShare = nameServiceDetailService.text
        let textToshare = descriptionDetatilService.text
        let priceToShare = priceDetailService.text
        let nameUserToShare = nameUserDetailService.text
        let objetsToShare = [nameServiceToShare, textToshare, priceToShare, nameUserToShare]
        let activityVC = UIActivityViewController(activityItems: objetsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityTypeAddToReadingList]
        activityVC.popoverPresentationController?.sourceView = sender as? UIView
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func goBack(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    // MARK: - Gesture Recognizer Views
    @IBAction func tapGestureImg01(sender: AnyObject) {
        if let serviceImages = service.images {
            if serviceImages.count > 0 {
                tappedView(sender as! UITapGestureRecognizer)
            }
        }
    }
    
    @IBAction func tapGestureImg02(sender: AnyObject) {
        if let serviceImages = service.images {
            if serviceImages.count > 1 {
                tappedView(sender as! UITapGestureRecognizer)
            }
        }
    }
    
    @IBAction func tapGestureImg03(sender: AnyObject) {
        if let serviceImages = service.images {
            if serviceImages.count > 2 {
                tappedView(sender as! UITapGestureRecognizer)
            }
        }
    }
    
    @IBAction func tapGestureImg04(sender: AnyObject) {
        if let serviceImages = service.images {
            if serviceImages.count > 3 {
                tappedView(sender as! UITapGestureRecognizer)
            }
        }
    }
    
    func tappedView(sender: UITapGestureRecognizer) {
        
        var popUpVIewController = PopUpImagesViewController()
        popUpVIewController = PopUpImagesViewController(nibName: popUpImagesNameImage, bundle: nil)
        popUpVIewController.showInView(
            self.view,
            withImage: imageTapped(sender).image ?? UIImage(named: emptyCameraNameImage),
            withMessage: nameServiceDetailService.text,
            animated: true)
    }
    
    func imageTapped(sender: UITapGestureRecognizer) -> UIImageView {
        
        if let selectImage = sender.view as? UIImageView {
            
            if selectImage.tag == 1 {
                self.selectImage = imgDetailService01
            }
            if selectImage.tag == 2 {
                self.selectImage = imgDetailService02
            }
            if selectImage.tag == 3 {
                self.selectImage = imgDetailService03
            }
            if selectImage.tag == 4 {
                self.selectImage = imgDetailService04
            }
        }
        return selectImage
    }
    
    
    // MARK - Private Methods
    private func responseServiceAPI(id: String, status: UInt, idUserResponse: String) -> Void {
        
        if !isConnectedToNetwork() {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
            return
        }
        
        if requestDataInProgress {
            showAlert(serviceRequestedToAttendTitle, message: apiConnectionNoPossible, controller: self)
            return
        }
        
        requestDataInProgress = true
        alertView.displayView(view, withTitle: pleaseWait)
        
        let session = Session.iCanGoSession()
        let _ = session.putChangeServiceStatus(id, status: status, idUserResponse: idUserResponse)
            
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                
                self!.alertView.hideView()
                self?.requestDataInProgress = false
                
                switch event {
                case let .Next(service):
                    
                    if service.status == StatusService.requestedToAttend.rawValue {
                        let okAction = UIAlertAction(title: ok, style: .Default, handler:{ (action: UIAlertAction!) in
                            
                            NSNotificationCenter.defaultCenter().postNotificationName(notificationKeyServicesChange,
                                object: self, userInfo: [self!.serviceId: service.id])
                            self!.navigationController?.popViewControllerAnimated(true)
                        })
                        let actions = [okAction]
                        showAlertWithActions(serviceRequestedToAttendTitle, message: serviceRequestedToAttendMessage, controller: self!, actions: actions)
                        
                    } else {
                        showAlert(serviceRequestedToAttendTitle, message: serviceRequestedToAttendKOMessage, controller: self!)
                    }
                    
                case .Error (let error):
                    showAlert(serviceRequestedToAttendTitle, message: serviceRequestedToAttendKOMessage, controller: self!)
                    print(error)
                    
                default:
                    break
                }
        }
    }
    
    private func deteteServiceAPI(id: String) -> Void {
        
        if !isConnectedToNetwork() {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
            return
        }
        
        if requestDataInProgress {
            showAlert(serviceDeleteTitle, message: apiConnectionNoPossible, controller: self)
            return
        }
        
        requestDataInProgress = true
        alertView.displayView(view, withTitle: pleaseWait)

        let session = Session.iCanGoSession()
        let _ = session.deleteService(id)
                    
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                
                self!.alertView.hideView()
                self?.requestDataInProgress = false
                
                switch event {
                case let .Next(service):

                    if service.deleted {
                        let okAction = UIAlertAction(title: ok, style: .Default, handler:{ (action: UIAlertAction!) in
                            
                            NSNotificationCenter.defaultCenter().postNotificationName(notificationKeyServicesChange,
                                object: self, userInfo: [self!.serviceId: service.id])
                            self!.navigationController?.popViewControllerAnimated(true)
                        })
                        let actions = [okAction]
                        showAlertWithActions(serviceDeleteTitle, message: serviceDeleteMessage, controller: self!, actions: actions)                    
                    } else {
                        showAlert(serviceDeleteTitle, message: serviceDeleteKOMessage, controller: self!)
                    }
                    
                case .Error (let error):
                    showAlert(serviceDeleteTitle, message: serviceDeleteKOMessage, controller: self!)
                    print(error)
                            
                default:
                    break
                }
            }
    }
    
    private func loadService(id: String) -> Void {
        
        if !isConnectedToNetwork()  {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
            return
        }
        
        if requestDataInProgress {
            showAlert(serviceDetailTitle, message: apiConnectionNoPossible, controller: self)
            return
        }
        
        requestDataInProgress = true
        alertView.displayView(view, withTitle: pleaseWait)
        
        let session = Session.iCanGoSession()
        let _ = session.getServiceById(id)
            
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                
                self!.alertView.hideView()
                self?.requestDataInProgress = false
                
                switch event {
                case let .Next(service):
                    self?.service = service
                    self?.showDataService()
                    
                case .Error (let error):
                    showAlert(serviceDetailTitle, message: serviceGetServiceKO, controller: self!)
                    print(error)
                    
                default:
                    break
                }
        }
        
    }
    
    private func setupViews() {
        
        nameServiceDetailService.text = ""
        nameUserDetailService.text = ""
        dataDetailService.text = ""
        publishedLabel.text = ""
        publishedDetailService.text = ""
        attendedLabel.text = ""
        caretedDetailsService.text = ""
        priceDetailService.text = ""
        descriptionDetatilService.text = ""
        photoUserDetailService.image = nil
        imgDetailService01.image = nil
        imgDetailService02.image = nil
        imgDetailService03.image = nil
        imgDetailService04.image = nil
        mapView.hidden = true
        addressLabel.hidden = true
        addressText.hidden = true
        clearServiceDetailBtnTrash.enabled = false
        contactPersonDetailServiceBtn.enabled = false
        contactPersonDetailServiceBtn.hidden = true
        contactPersonDetailServiceBtn.setImage(nil, forState: UIControlState.Normal)
    }
    
    private func showDataService() {
        
        // Show data of service.
        nameServiceDetailService.text  = service.name
        if service.ownerImage != nil {
            loadImage(service.ownerImage!, imageView: photoUserDetailService, withAnimation: false)
        }
        nameUserDetailService.text = "\(service.userFirstName) \(service.userLastName)"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
        dataDetailService.text = dateFormatter.stringFromDate(service.dateCreated)
        publishedDetailService.text = String(service.numPublishedServices)
        caretedDetailsService.text = String(service.numAttendedServices)
        priceDetailService.text = String(format: priceFormat, service.price)
        descriptionDetatilService.text = service.description
        
        // Show geoposition or address service.
        if let latitude = service.latitude,
            longitude = service.longitude {
            
            mapView.hidden = false
            addressLabel.hidden = true
            addressText.hidden = true
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let serviceAnnotationMap = ServiceAnnotationMap(coordinate: coordinate, title: "", subtitle: "", service: service)
            mapView.addAnnotation(serviceAnnotationMap)
            
            var userRegion: MKCoordinateRegion = MKCoordinateRegion()
            userRegion.center.latitude = latitude
            userRegion.center.longitude = longitude
            userRegion.span.latitudeDelta = 0.001000
            userRegion.span.longitudeDelta = 0.001000
            mapView.setRegion(userRegion, animated: true)
        } else {
            if service.address != nil {
                mapView.hidden = true
                addressLabel.hidden = false
                addressText.hidden = false
                addressText.text = service.address
            }
        }
        
        // Show service images
        if let serviceImages = service.images {
            
            if serviceImages.count > 0 {
                loadImage(serviceImages[0].imageUrl, imageView: imgDetailService01, withAnimation: true)
            }
            
            if serviceImages.count > 1 {
                loadImage(serviceImages[1].imageUrl, imageView: imgDetailService02, withAnimation: true)
            }
            
            if serviceImages.count > 2 {
                loadImage(serviceImages[2].imageUrl, imageView: imgDetailService03, withAnimation: true)
            }
            
            if serviceImages.count > 3 {
                loadImage(serviceImages[3].imageUrl, imageView: imgDetailService04, withAnimation: true)
            }
        }
        
        if (service.status == StatusService.pending.rawValue && !service.deleted) {
            self.user = loadUserAuthInfo()
            if user.id != "" {

                // Validate enabled button response Service.
                if service.idUserRequest != user.id {
                    contactPersonDetailServiceBtn.enabled = true
                    contactPersonDetailServiceBtn.hidden = false
                }
                
                // Show delete service
                if service.idUserRequest == user.id {
                    clearServiceDetailBtnTrash.enabled = true
                }
            }
        }
    }
}
