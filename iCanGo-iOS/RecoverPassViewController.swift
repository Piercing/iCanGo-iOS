//
//  RecoverPassViewController.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 21/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

protocol ComunicationRecoverControllerDelegate {
    func back(index: Int)
}


class RecoverPassViewController: UIViewController {
    
    let titleView = "Recover Password"
    var delegate: ComunicationRecoverControllerDelegate? = nil
    
    // MARK: - Properties
    
    @IBOutlet weak var imageProfileUser: UIImageView!
    @IBOutlet weak var nameProfileUser: UITextField!
    @IBOutlet weak var emailProfileUser: UITextField!
    @IBOutlet weak var newPassProfileUser: UITextField!
    @IBOutlet weak var repeatPassProfileUser: UITextField!

    // MARK : - Init
    
    convenience init() {
        self.init(nibName: "RecoverPassView", bundle: nil)
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = Appearance.setupUI(self.view, title: self.titleView)
        self.title = title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK : - Actions
    
    @IBAction func btnCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func btnSave(sender: AnyObject) {

        
    }

    
}
