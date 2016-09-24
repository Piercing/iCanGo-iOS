//
//  ShowServiceImageViewController.swift
//  iCanGo-iOS
//
//  Created by Pedro Martin Gomez on 24/9/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class ShowServiceImageViewController: UIViewController {
    
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var serviceImageView: UIImageView!
    
    var serviceImage: ServiceImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        updateUI()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func showImage() {
        if serviceImage == nil {
            return
        }
        
        loadImage((serviceImage?.imageUrl)!, imageView: serviceImageView, withAnimation: true)
    }
    
    func updateUI() {
        
        self.navBar.title = "Service Image"
        let closeAction = UIBarButtonItem(title: "close", style: .Plain, target: self, action: #selector(self.closeAction))
        closeAction.tintColor = UIColor.whiteColor()
        
        self.navBar.rightBarButtonItem = closeAction
        
        if !isConnectedToNetwork()  {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
            return
        }
        
        if let imageURL = serviceImage?.imageUrl {
            loadImage(imageURL, imageView: serviceImageView, withAnimation: true)
        }
        
    }
    
    func closeAction() {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
}
