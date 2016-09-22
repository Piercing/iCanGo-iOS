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
import AZSClient

class DetailServiceViewController: UIViewController, UINavigationControllerDelegate {
    
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
    
    private var imagePicker: UIImagePickerController? = UIImagePickerController()
    private var newUrlPhoto: NSURL = NSURL()
    private var newDataPhoto: NSData = NSData()
    private var selectedImageView: UIImageView?
    
    //var popUpVIewController: PopUpImagesViewController?

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
    private var canEdit: Bool = false
    
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
            hideAddImageIcon()
        publishedLabel.text = publishedText
        attendedLabel.text = attendedText
        
        // Show data service.
        //showDataService()
        canEdit = self.navigationController?.viewControllers[0] is MyProfileViewController
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
    
    func zoomIn(imageView: UIImageView)  {
        print("Zooming in the image \(imageView.tag)")
    }
    
    // MARK: - Gesture Recognizer Views
    @IBAction func tapGestureImg01(sender: AnyObject) {
        selectedImageView = imgDetailService01
        if self.navigationController?.viewControllers[0] is MyProfileViewController {
            // We came from My Profile, so seems that the user wants to change the image
            showPhotoOptions()
            return
        }
        
        // We came from Services list, so the idea here is to zoom in the image
        zoomIn(selectedImageView!)
        
    }
    
    @IBAction func tapGestureImg02(sender: AnyObject) {
        selectedImageView = imgDetailService02
        if self.navigationController?.viewControllers[0] is MyProfileViewController {
            // We came from My Profile, so seems that the user wants to change the image
            showPhotoOptions()
            return
        }
        
        // We came from Services list, so the idea here is to zoom in the image
        zoomIn(selectedImageView!)
    }
    
    @IBAction func tapGestureImg03(sender: AnyObject) {
        selectedImageView = imgDetailService03
        selectedImageView?.tag = 3
        if self.navigationController?.viewControllers[0] is MyProfileViewController {
            // We came from My Profile, so seems that the user wants to change the image
            showPhotoOptions()
            return
        }
        
        // We came from Services list, so the idea here is to zoom in the image
        zoomIn(selectedImageView!)
    }
    
    @IBAction func tapGestureImg04(sender: AnyObject) {
        selectedImageView = imgDetailService04
        if self.navigationController?.viewControllers[0] is MyProfileViewController {
            // We came from My Profile, so seems that the user wants to change the image
            showPhotoOptions()
            return
        }
        
        // We came from Services list, so the idea here is to zoom in the image
        zoomIn(selectedImageView!)
    }
    
    func showPhotoOptions() {
        let alert: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cameraAction = UIAlertAction(title: alertCameraTakePhoto, style: UIAlertActionStyle.Default) {
            UIAlertAction in
            openCamera(self.imagePicker!, rootController: self)
        }
        
        let galleryAction = UIAlertAction(title: alertCameraSelectPhoto, style: UIAlertActionStyle.Default) {
            UIAlertAction in
            openGallery(self.imagePicker!, rootController: self)
        }
        
        let cancelAction = UIAlertAction(title: cancel, style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
        }
        
        // Add the actions
        imagePicker?.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK - Private Methods
    
    private func hideAddImageIcon() {
        imgDetailService01.hidden = true
        imgDetailService02.hidden = true
        imgDetailService03.hidden = true
        imgDetailService04.hidden = true
    }
    
    private func showAddImageIcon() {
        
        if let serviceImages = service.images {
            
            switch serviceImages.count {
            case 0:
                if canEdit {
                    imgDetailService01.hidden = false
                    imgDetailService01.fadeOut(duration: 0.0)
                    imgDetailService01.fadeIn()
                }
                break
            case 1:
                imgDetailService01.hidden = false
                imgDetailService01.fadeOut(duration: 0.0)
                imgDetailService01.fadeIn()
                if canEdit {

                    imgDetailService02.hidden = false
                    imgDetailService02.fadeOut(duration: 0.0)
                    imgDetailService02.fadeIn()
                }
                break
            case 2:
                imgDetailService01.hidden = false
                imgDetailService01.fadeOut(duration: 0.0)
                imgDetailService01.fadeIn()
                imgDetailService02.hidden = false
                imgDetailService02.fadeOut(duration: 0.0)
                imgDetailService02.fadeIn()
                if canEdit {

                    imgDetailService03.hidden = false
                    imgDetailService03.fadeOut(duration: 0.0)
                    imgDetailService03.fadeIn()
                }
                break
            case 3:
                imgDetailService01.hidden = false
                imgDetailService01.fadeOut(duration: 0.0)
                imgDetailService01.fadeIn()
                imgDetailService02.hidden = false
                imgDetailService02.fadeOut(duration: 0.0)
                imgDetailService02.fadeIn()
                imgDetailService03.hidden = false
                imgDetailService03.fadeOut(duration: 0.0)
                imgDetailService03.fadeIn()
                if canEdit {

                    imgDetailService04.hidden = false
                    imgDetailService04.fadeOut(duration: 0.0)
                    imgDetailService04.fadeIn()
                }
                break
            case 4:
                imgDetailService01.hidden = false
                imgDetailService01.fadeOut(duration: 0.0)
                imgDetailService01.fadeIn()
                imgDetailService02.hidden = false
                imgDetailService02.fadeOut(duration: 0.0)
                imgDetailService02.fadeIn()
                imgDetailService03.hidden = false
                imgDetailService03.fadeOut(duration: 0.0)
                imgDetailService03.fadeIn()
                imgDetailService04.hidden = false
                imgDetailService04.fadeOut(duration: 0.0)
                imgDetailService04.fadeIn()
                break
            default:
                break
            }
        }
        
    }
    
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
                    self?.showAddImageIcon()
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
    
    func saveImage()  {
        // Validate all data.
        let okAction = UIAlertAction(title: ok, style: .Default, handler:{ (action: UIAlertAction!) in
            
            self.uploadImageToStorage(self.newDataPhoto, blobName: "\(self.service.id)_\(self.selectedImageView!.tag).png")

        })
        let cancelAction = UIAlertAction(title: cancel, style: .Cancel, handler: nil)
        let actions = [okAction, cancelAction]
        showAlertWithActions(serviceImageTitle, message: serviceImageConfirmationMessage, controller: self, actions: actions)
    }
    
    private func putDataImageService() {
        
        if !isConnectedToNetwork()  {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
            return
        }
        
        if requestDataInProgress {
            showAlert(userProfileTitle, message: apiConnectionNoPossible, controller: self)
            return
        }
        
        requestDataInProgress = true
        alertView.displayView(view, withTitle: pleaseWait)
        
        //let serviceImageId = service.images!.count >= selectedImageView!.tag service.images![selectedImageView!.tag].id
        
        let imageIndex = selectedImageView!.tag - 1
        
        let session = Session.iCanGoSession()
        let _ = session.putServiceImage(service.images![imageIndex].id, idService: service.id, imageUrl: self.newUrlPhoto)
            
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                
                self!.alertView.hideView()
                self?.requestDataInProgress = false
                
                switch event {
                case let .Next(serviceImage):
                    
                    //print(serviceImage)
                    
                    if (self?.service.images![imageIndex].id)! == serviceImage.id {
                        
                        self!.selectedImageView?.image = UIImage(data: self!.newDataPhoto)
                        
                        let okAction = UIAlertAction(title: ok, style: .Default, handler: nil)
                        let actions = [okAction]
                        showAlertWithActions(serviceImageTitle, message: serviceImageMessage, controller: self!, actions: actions)
                        
                    } else {
                        showAlert(serviceImageTitle, message: serviceImageKOMessage, controller: self!)
                    }
                    
                case .Error (let error):
                    showAlert(serviceImageTitle, message: serviceImageKOMessage, controller: self!)
                    print(error)
                    
                default:
                    break
                }
        }
    }
    
    private func postDataImageService() {
        
        if !isConnectedToNetwork()  {
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
        let _ = session.postServiceImage(service.id, imageUrl: self.newUrlPhoto)
            
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                
                self!.alertView.hideView()
                self?.requestDataInProgress = false
                
                switch event {
                case let .Next(serviceImage):
                    
                    //print(serviceImage)
                    self!.service.images?.append(serviceImage)
                    self!.showAddImageIcon()
                    
                    self!.selectedImageView?.image = UIImage(data: self!.newDataPhoto)
                    
                    let okAction = UIAlertAction(title: ok, style: .Default, handler: nil)
                    let actions = [okAction]
                    showAlertWithActions(serviceImageTitle, message: serviceImageMessage, controller: self!, actions: actions)
                    
                case .Error (let error):
                    showAlert(serviceImageTitle, message: serviceImageKOMessage, controller: self!)
                    print(error)
                    
                default:
                    break
                }
        }
    }
    
    func uploadImageToStorage(imageData : NSData, blobName : String) {
        
        if !isConnectedToNetwork()  {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
            return
        }
        
        if requestDataInProgress {
            showAlert(userProfileTitle, message: apiConnectionNoPossible, controller: self)
            return
        }
        
        requestDataInProgress = true
        alertView.displayView(view, withTitle: pleaseWait)
        
        var newImage: Bool = self.service.images!.count == 4
        
        if self.service.images!.count == 0 {
            newImage = true
        }
        else {
            if self.service.images!.count == selectedImageView!.tag {
                newImage = false
            }
            else {
                if self.service.images!.count < selectedImageView!.tag {
                    newImage = true
                }
            }
            
        }
        
        let session = Session.iCanGoSession()
        let _ = session.getUrlSaS(AzureContainers.services.rawValue, blobName: blobName) 
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                
                self!.alertView.hideView()
                self?.requestDataInProgress = false
                
                switch event {
                case let .Next(data):
                    
                    // Once we get URLSas, we prepare all necessary for upload to azure.
                    let endPoint = "\(data.urlWithContainerAndWithOutBlobName)?\(data.sasToken)"
                    
                    // We create reference to container in Azure
                    var error: NSError?
                    let container = AZSCloudBlobContainer(url: NSURL(string: endPoint)!, error: &error)
                    
                    // We create reference to our blob with the blobname
                    let blobLocal = container.blockBlobReferenceFromName(blobName)
                    
                    // We convert image to Base64
                    //let imageBase64String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
                    
                    // Upload image file to Azure
                    //blobLocal.uploadFromText(imageBase64String, completionHandler: { (error: NSError?) -> Void in
                    blobLocal.uploadFromData(imageData, completionHandler: { (error: NSError?) -> Void in
                        
                        if error == nil {
                            // Save url photo and the rest data user.
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self!.newUrlPhoto = NSURL(string: data.urlWithContainerAndBlobName)!
                                
                                if newImage {
                                    self!.postDataImageService()
                                }
                                else {
                                    self!.putDataImageService()
                                }
                            })
                            
                        } else {
                            showAlert(userProfileTitle, message: userProfileKOMessage, controller: self!)
                            print(error)
                        }
                    })
                    
                case .Error (let error):
                    showAlert(userProfileTitle, message: userProfileKOMessage, controller: self!)
                    print(error)
                    
                default:
                    break
                }
        }
        
    }
}

// MARK: - Extensions - UITextFieldDelegate
extension DetailServiceViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        // Resize and reduced profile user photo.
        newDataPhoto = image.reducedImage()
        //selectedImageView?.image = UIImage(data: newDataPhoto)
        
        saveImage()
    }
}
