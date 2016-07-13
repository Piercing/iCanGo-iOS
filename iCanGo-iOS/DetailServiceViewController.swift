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
    
    @IBOutlet weak var contactPersonDetailServiceBtn: UIButton!
    @IBOutlet weak var clearServiceDetailBtn: UIButton!
    @IBOutlet weak var nameUserDetailService: UILabel!
    @IBOutlet weak var dataDetailService: UILabel!
    @IBOutlet weak var publishedDetailService: UILabel!
    @IBOutlet weak var caretedDetailsService: UILabel!
    @IBOutlet weak var priceDetailService: UILabel!
    @IBOutlet weak var descriptionDetatilService: UITextView!
    
    let titleView = "Detail Services"
    
    // MARK: - Init
    convenience init() {
        self.init(nibName: "DetailService", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = Appearance.setupUI(self.view, title: self.titleView)
        self.title = title
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        
        contactPersonDetailServiceBtn.layer.cornerRadius = 5
        clearServiceDetailBtn.layer.cornerRadius = 5
    }
    
    // MARK: Methods

    
    // MARK: - Actions
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnContactPersonDetailService(sender: AnyObject) {
        print("Tapped btn contact user Detail Service")
    }
    @IBAction func btnDeleteServiceDetail(sender: AnyObject) {
        print("Tapped btn delete Detail Service")
    }
    @IBAction func btnSharedDetatilService(sender: AnyObject) {
        print("Tapped btn shared Detail Service")
    }
    @IBAction func btnBackDetailService(sender: AnyObject) {
        print("Tapped btn back Detail Service")
    }
}
