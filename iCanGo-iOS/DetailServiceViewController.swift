//
//  DetailService.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 12/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

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
    
    var lastRotation = CGFloat()
    let titleView = "Detail Services"
    let tapRecognizer = UITapGestureRecognizer()
    var popVIewController = PopUpImagesViewController()
    var selectImage =  UIImageView()
    
    // MARK: - Init
    convenience init() {
        self.init(nibName: "DetailServiceView", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = Appearance.setupUI(self.view, title: self.titleView)
        self.title = title
        
        Appearance.addDidLayoutSubviewsFourImages(
            imgDetailService01,
            img2: imgDetailService02,
            img3: imgDetailService03,
            img4: imgDetailService04)

        gestureReconizerForImages()
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        
        contactPersonDetailServiceBtn.layer.cornerRadius = 5
        clearServiceDetailBtn.layer.cornerRadius = 5
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
        print("Tapped btn delete Detail Service")
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
//
//    @IBAction func selectImg01(sender: UIImageView) {
//        //openPopover(sender)
//    }
//    
//    @IBAction func selectImg02(sender: UIImageView) {
//        //openPopover(sender)
//    }
//    
//    @IBAction func selectImg03(sender: UIImageView) {
//        //openPopover(sender)
//    }
//    
//    @IBAction func selectImg04(sender: UIImageView) {
//        //openPopover(sender)
//    }

    
    // MARK: - Gesture Recognizer Views
    
    func gestureReconizerForImages() {
        
        self.tapRecognizer.addTarget(self, action: #selector(DetailServiceViewController.tappedView))
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
        
        selectImage = (sender.view as? UIImageView)!
        
        print("tapped reconigzer")
        self.popVIewController = PopUpImagesViewController(nibName: "PopUpImagesView", bundle: nil)
        self.popVIewController.showInView(self.view, withImage: selectImage.image ?? UIImage(named: "camera"), withMessage: nameServiceDetailService.text, animated: true)
        
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
}

















