//
//  PopUpImagesViewController.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 17/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class PopUpImagesViewController: UIViewController {
    
    
    // MARK: - Properties
    
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var popUpImage: UIImageView!
    @IBOutlet weak var titleService: UILabel!
    
    let detailService = DetailServiceViewController()
    
    //    // MARK: - Init
    //    convenience init() {
    //        self.init(nibName: "PopUpImagesView", bundle: nil)
    //    }
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    // Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popUpImages()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Methods
    
    func popUpImages() {
        
        self.view.frame = CGRectMake(65, 110, detailService.view.frame.size.width / 2.5, detailService.view.frame.size.height / 2.5)
        
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        self.popUpView.layer.cornerRadius = 5
        self.popUpView.layer.shadowOpacity = 0.8
        self.popUpView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    }
    
    func showInView(aView: UIView!, withImage image : UIImage!, withMessage message: String!, animated: Bool) {
        
        let popUpImagesViewController = PopUpImagesViewController()

        presentViewController(popUpImagesViewController, animated: true, completion: nil)
        //popUpImagesViewController

        aView.addSubview(self.view)
        popUpImage!.image = image
        titleService!.text = message
        if animated
        {
            self.showAnimate()
        }
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0
        UIView.animateWithDuration(0.5, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        });
    }
    
    func removeAnimate() {
        UIView.animateWithDuration(0.5, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0
            }, completion:{(finished : Bool)  in
                if finished
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    // MARK: - Actions
    
    @IBAction func popUpClose(sender: AnyObject) {
        removeAnimate()
    }
}







