//
//  CreateServiceTabViewController.swift
//  iCanGo-iOS
//
//  Created by MacBook Pro on 5/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class HighServiceViewController: UIViewController {
    
    // MARK: - Properties
    let titleView = "High Service"
    
    @IBOutlet weak var btnTwitterHighService: UIButton!
    @IBOutlet weak var btnFacebookHighService: UIButton!
    @IBOutlet weak var btnGooglePlusHighService: UIButton!
    @IBOutlet weak var pickerHighService: UIPickerView!
    @IBOutlet weak var labelCoinHighService: UILabel!
    
    let pickerData = ["€","$","¥"]
    
    // MARK: - Init
    convenience init() {
        self.init(nibName: "HighServiceView", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerHighService.dataSource = self
        pickerHighService.delegate = self
        
        let title = Appearance.setupUI(self.view, title: self.titleView)
        self.title = title
        
        Appearance.customizeAppearance(self.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addService(sender: AnyObject) {
        print("Tapped buttom add service")
    }
    @IBAction func cancelHighService(sender: AnyObject) {
        print("Tapped buttom cancel High service")
    }
    @IBAction func twitterHighServiceAction(sender: AnyObject) {
        print("Tapped buttom Twitter")
    }
    
    @IBAction func facebookHighServiceAction(sender: AnyObject) {
        print("Tapped buttom Facebook")
    }
    @IBAction func googlePlusHighServiceAction(sender: AnyObject) {
        print("Tapped buttom Google+")
    }
    @IBAction func linkedinHighServicesAction(sender: AnyObject) {
        print("Tapped buttom Linkedin")
    }
}

// MARK: - Delegates & Data source
extension HighServiceViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - Data Source
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // MARK: - Delegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        labelCoinHighService.text = pickerData[row]
    }
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData[row]
        let title = NSAttributedString(
            string: titleData,
            attributes: [NSFontAttributeName: UIFont(name: "Avenir Next", size: 13.0)!,
            NSForegroundColorAttributeName:UIColor(red: 26/255, green: 147/255, blue: 165/255, alpha: 1.0)])
        return title
    }
}











