//
//  LoginViewController.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 23/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class LoginViewControllerJC: UIViewController {
    
    // MARK: - Properties
    /*
    @IBOutlet weak var txtFieldUser: UITextField!
    @IBOutlet weak var txtFieldPassw: UITextField!
    @IBOutlet weak var btnInitSession: UIButton!
    @IBOutlet weak var btnForgetPassw: UIButton!
    @IBOutlet weak var btnNotRegister: UIButton!
    */
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Status Bar Color
        let statusBarColor = UIColor(red: 26/255, green: 147/255, blue: 165/255, alpha: 1)
        let colorStatusBar: UIView = UIView(frame: CGRectMake(0, 0,self.view.frame.size.width, 20))
        colorStatusBar.backgroundColor = statusBarColor
        self.view.addSubview(colorStatusBar)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    /*@IBAction func btnInitSS(sender: AnyObject) {
    }
    
    @IBAction func btnForgetPASS(sender: AnyObject) {
    }
    
    @IBAction func btnNoRG(sender: AnyObject) {
    }*/
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

// MARK: - Extensions - Delegates
/*extension UIViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)        
        return true
    }
}*/