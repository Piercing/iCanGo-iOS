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
    
    let titleView = "Detail Services"
    //var tapRecognizer: UITapGestureRecognizer? = nil
    var popUpVIewController: PopUpImagesViewController?
    var selectImage =  UIImageView()
    
    // MARK: - Init
    convenience init() {
        self.init(nibName: "DetailServiceView", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = Appearance.setupUI(self.view, title: self.titleView)
        self.title = title
        
        //gestureReconizerForImages()
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
    
    @IBAction func tapGestureImg01(sender: AnyObject) {
        tappedView(sender as! UITapGestureRecognizer)
    }
    
    @IBAction func tapGestureImg02(sender: AnyObject) {
        tappedView(sender as! UITapGestureRecognizer)
    }
    
    @IBAction func tapGestureImg03(sender: AnyObject) {
        tappedView(sender as! UITapGestureRecognizer)
    }
    
    @IBAction func tapGestureImg04(sender: AnyObject) {
        tappedView(sender as! UITapGestureRecognizer)
    }
    // MARK: - Gesture Recognizer Views
    
    func tappedView(sender: UITapGestureRecognizer) {
        
        var popUpVIewController = PopUpImagesViewController()

        popUpVIewController = PopUpImagesViewController(nibName: "PopUpImagesView", bundle: nil)
        popUpVIewController.showInView(self.view, withImage: imageTapped(sender).image ?? UIImage(named: "1024-emptyCamera-center-ios"), withMessage: nameServiceDetailService.text, animated: true)
    }
    
    func imageTapped(sender: UITapGestureRecognizer) -> UIImageView {
        
        if let selectImage = sender.view as? UIImageView{
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
}

















