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
    @IBOutlet weak var clearServiceDetailBtn: UIButton!
    @IBOutlet weak var nameUserDetailService: UILabel!
    @IBOutlet weak var dataDetailService: UILabel!
    @IBOutlet weak var photoUserDetailService: CircularImageView!
    @IBOutlet weak var publishedDetailService: UILabel!
    @IBOutlet weak var caretedDetailsService: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var priceDetailService: UILabel!
    @IBOutlet weak var descriptionDetatilService: UITextView!
    @IBOutlet weak var publishedLabel: UILabel!
    @IBOutlet weak var imgDetailService01: UIImageView!
    @IBOutlet weak var attendedLabel: UILabel!
    @IBOutlet weak var imgDetailService02: UIImageView!
    @IBOutlet weak var imgDetailService03: UIImageView!
    @IBOutlet weak var imgDetailService04: UIImageView!
    
    var popUpVIewController: PopUpImagesViewController?
    var selectImage =  UIImageView()
    private var requestDataInProgress: Bool!
    private var service: Service!
    
    // MARK: - Constant.
    let titleView = "Detail Service"
    
    
    // MARK: - Init
    convenience init(service: Service) {
        
        self.init(nibName: "DetailServiceView", bundle: nil)
        
        // Initialize variables.
        self.requestDataInProgress = false
        self.service = service
    }
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let title = Appearance.setupUI(self.view, title: self.titleView)
        self.title = title
        
        // Initialize data en view.
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
        contactPersonDetailServiceBtn.setImage(nil, forState: UIControlState.Normal)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        // Get data from API.
        loadService(service.id)
        
        // Load default images and textLabel.
        contactPersonDetailServiceBtn.setImage(UIImage.init(named:"conversation03"), forState: UIControlState.Normal)
        photoUserDetailService.image = UIImage.init(named: "content-avatar-default-ios")
        imgDetailService01.image = UIImage.init(named: "1024-emptyCamera-center-ios")
        imgDetailService02.image = UIImage.init(named: "1024-emptyCamera-center-ios")
        imgDetailService03.image = UIImage.init(named: "1024-emptyCamera-center-ios")
        imgDetailService04.image = UIImage.init(named: "1024-emptyCamera-center-ios")
        publishedLabel.text = publishedText
        attendedLabel.text = attendedText
        
        // Show data service.
        showDataService()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Actions
    @IBAction func btnContactPersonDetailService(sender: AnyObject) {
        print("Tapped btn contact user Detail Service")
    }
    
    @IBAction func btnDeleteServiceDetail(sender: AnyObject) {
        deteteServiceAPI(service.id)
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
    
    @IBAction func btnBackDetailService(sender: AnyObject) {
        print("Tapped btn back Detail Service")
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
        popUpVIewController = PopUpImagesViewController(nibName: "PopUpImagesView", bundle: nil)
        popUpVIewController.showInView(
            self.view,
            withImage: imageTapped(sender).image ?? UIImage(named: "1024-emptyCamera-center-ios"),
            withMessage: nameServiceDetailService.text,
            animated: true)
    }
    
    func imageTapped(sender: UITapGestureRecognizer) -> UIImageView {
        
        if let selectImage = sender.view as? UIImageView {
            
            if selectImage.tag == 1 {
                self.selectImage = imgDetailService01
                
            } else if selectImage.tag == 2 {
                self.selectImage = imgDetailService02
                
            } else if selectImage.tag == 3 {
                self.selectImage = imgDetailService03
                
            } else if selectImage.tag == 4{
                self.selectImage = imgDetailService04
            }
        }
        return selectImage
    }
    
    
    // MARK - Private Methods
    private func deteteServiceAPI(id: String) -> Void {
        
        if isConnectedToNetwork() {
            
            if requestDataInProgress == false {
                
                requestDataInProgress = true
                let session = Session.iCanGoSession()
                let _ = session.deleteService(id)
                    
                    .observeOn(MainScheduler.instance)
                    .subscribe { [weak self] event in
                        
                        switch event {
                        case .Next(_):
                            showAlert(serviceDeleteTitle, message: serviceDeleteMessage, controller: self!)
                            self?.requestDataInProgress = false
                            
                        case .Error (let error):
                            self?.requestDataInProgress = false
                            print(error)
                            
                        default:
                            self?.requestDataInProgress = false
                        }
                }
            }
        } else {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
        }
    }
    
    private func loadService(id: String) -> Void {
        
        if isConnectedToNetwork() {
            
            if requestDataInProgress == false {
                
                requestDataInProgress = true
                let session = Session.iCanGoSession()
                let _ = session.getServiceById(id)
                    
                    .observeOn(MainScheduler.instance)
                    .subscribe { [weak self] event in
                        
                        switch event {
                        case let .Next(service):
                            self?.service = service
                            self?.showDataService()
                            self?.requestDataInProgress = false
                            
                        case .Error (let error):
                            self?.requestDataInProgress = false
                            print(error)
                            
                        default:
                            self?.requestDataInProgress = false
                        }
                }
            }
        } else {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
        }
    }
    
    private func showDataService() {
        
        nameServiceDetailService.text  = service.name
        if service.ownerImage != nil {
            loadImage(service.ownerImage!, imageView: photoUserDetailService, withAnimation: false)
        }
        nameUserDetailService.text     = service.userFirstName + " " + service.userLastName
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dataDetailService.text         = dateFormatter.stringFromDate(service.dateCreated)
        publishedDetailService.text    = String(service.numPublishedServices)
        caretedDetailsService.text     = String(service.numAttendedServices)
        priceDetailService.text        = String(format: "%.2f", service.price)
        descriptionDetatilService.text = service.description
        
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
        
        if let latitude = service.latitude,
            longitude = service.longitude {
            
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
            mapView.hidden = true
        }
    }    
}
