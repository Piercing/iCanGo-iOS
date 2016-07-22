//
//  DetailService.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 12/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit
import RxSwift

class DetailServiceViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var nameServiceDetailService: UILabel!
    @IBOutlet weak var contactPersonDetailServiceBtn: UIButton!
    @IBOutlet weak var clearServiceDetailBtn: UIButton!
    @IBOutlet weak var nameUserDetailService: UILabel!
    @IBOutlet weak var dataDetailService: UILabel!
    @IBOutlet weak var publishedDetailService: UILabel!
    @IBOutlet weak var caretedDetailsService: UILabel!
    @IBOutlet weak var priceDetailService: UILabel!
    @IBOutlet weak var descriptionDetatilService: UITextView!
    
    @IBOutlet weak var imgDetailService01: UIImageView!
    @IBOutlet weak var imgDetailService02: UIImageView!
    @IBOutlet weak var imgDetailService03: UIImageView!
    @IBOutlet weak var imgDetailService04: UIImageView!
    
    let titleView = "Detail Services"
    //var tapRecognizer: UITapGestureRecognizer? = nil
    var popUpVIewController: PopUpImagesViewController?
    var selectImage =  UIImageView()
    var serviceModel: Service!
    
    // MARK: - Init
    convenience init(service: Service) {
        
        self.init(nibName: "DetailServiceView", bundle: nil)
        self.serviceModel = service
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = Appearance.setupUI(self.view, title: self.titleView)
        self.title = title
        
        nameServiceDetailService.text  = serviceModel.name
        nameUserDetailService.text     = serviceModel.userFirstName + " " + serviceModel.userLastName
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dataDetailService.text         = dateFormatter.stringFromDate(serviceModel.dateCreated)
        publishedDetailService.text    = String(serviceModel.numPublishedServices)
        caretedDetailsService.text     = String(serviceModel.numAttendedServices)
        priceDetailService.text        = String(format: "%.2f", serviceModel.price)
        descriptionDetatilService.text = serviceModel.description
        
        if let serviceImages = serviceModel.images {
            
            loadImage(serviceImages[0].imageUrl, imageView: imgDetailService01)
            
            if serviceImages[1].id != "" {
                loadImage(serviceImages[1].imageUrl, imageView: imgDetailService02)
            }
            
            if serviceImages[2].id != "" {
                loadImage(serviceImages[2].imageUrl, imageView: imgDetailService03)
            }
            
            if serviceImages[3].id != "" {
                loadImage(serviceImages[3].imageUrl, imageView: imgDetailService04)
            }
        }
        
        gestureReconizerForImages()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func btnContactPersonDetailService(sender: AnyObject) {
        print("Tapped btn contact user Detail Service")
    }
    
    @IBAction func btnDeleteServiceDetail(sender: AnyObject) {
        deteteServiceAPI(serviceModel.id)
    }
    
    @IBAction func btnSharedDetatilService(sender: AnyObject) {
        
        let nameServiceToShare = nameServiceDetailService.text
        let textToshare = descriptionDetatilService.text
        let priceToShare = priceDetailService.text
        let nameUserToShare = nameUserDetailService.text
        //let locationToSahre
        
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
    
    func gestureReconizerForImages() {
        
        let tapRecognizer  = UITapGestureRecognizer()
        
        tapRecognizer.addTarget(self, action: #selector(DetailServiceViewController.tappedView))
        tapRecognizer.numberOfTapsRequired = 1
        
        imgDetailService01.userInteractionEnabled = true
        imgDetailService02.userInteractionEnabled = true
        imgDetailService03.userInteractionEnabled = true
        imgDetailService04.userInteractionEnabled = true
        
        imgDetailService01.addGestureRecognizer(tapRecognizer)
        imgDetailService02.addGestureRecognizer(tapRecognizer)
        imgDetailService03.addGestureRecognizer(tapRecognizer)
        imgDetailService04.addGestureRecognizer(tapRecognizer)
        
    }
    
    func tappedView(sender: UITapGestureRecognizer) {
        
        var popUpVIewController = PopUpImagesViewController()
        selectImage = (sender.view as? UIImageView)!
        
        print("tapped reconigzer")
        popUpVIewController = PopUpImagesViewController(nibName: "PopUpImagesView", bundle: nil)
        popUpVIewController.showInView(self.view, withImage: selectImage.image ?? UIImage(named: "camera"), withMessage: nameServiceDetailService.text, animated: true)
        
    }
    //
    //    func imageTapped(img: UIImage) -> UIImage {
    //
    //        switch img {
    //        case img.isEqual(imgDetailService01):
    //            return imgDetailService01.image!
    //        case img.isEqual(imgDetailService02):
    //            return imgDetailService02.image!
    //        case img.isEqual(imgDetailService03):
    //            return imgDetailService03.image!
    //        case img.isEqual(imgDetailService04):
    //            return imgDetailService04.image!
    //        default:
    //            return UIImage(named: "camera")!
    //        }
    //    }
    
    
    // MARK - Private Methods
    private func deteteServiceAPI(id: String) -> Void {
        
        let session = Session.iCanGoSession()
        // TODO: Parameter Rows pendin
        let _ = session.deleteService(id)
            
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                
                switch event {
                case .Next(_):
                    showAlert(serviceDeleteTitle, message: serviceDeleteMessage, controller: self!)
                    break
                    
                case .Error (let error):
                    print(error)
                    
                default:
                    break
                }
        }
    }
}




