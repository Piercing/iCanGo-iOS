//
//  LoginViewController.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 23/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var txtFieldUser: UITextField!
    @IBOutlet weak var txtFieldPassw: UITextField!
    @IBOutlet weak var btnInitSession: UIButton!
    @IBOutlet weak var btnForgetPassw: UIButton!
    @IBOutlet weak var btnNotRegister: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var loginInProgress: Bool!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeAppearance()
        
        activityIndicatorView.hidden = true
        loginInProgress = false
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        txtFieldUser.layer.cornerRadius = 5
        txtFieldPassw.layer.cornerRadius = 5
        btnInitSession.layer.cornerRadius = 5
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        txtFieldUser.resignFirstResponder()
        txtFieldPassw.resignFirstResponder()
        
    }
    
    // MARK: - Appearance
    
    func customizeAppearance() {
        // Status Bar Color
        let statusBarColor = UIColor(red: 26/255, green: 147/255, blue: 165/255, alpha: 1)
        let colorStatusBar: UIView = UIView(frame: CGRectMake(0, 0,self.view.frame.size.width, 20))
        colorStatusBar.backgroundColor = statusBarColor
        self.view.addSubview(colorStatusBar)
    }
    
    
    // MARK: - Actions
    
    @IBAction func btnInitSS(sender: AnyObject) {
        
        // Check info of login fields.
        if (txtFieldUser.text != "" && txtFieldPassw.text != "" && !loginInProgress) {
            
            loginInProgressRequest()
            
            let session = Session.iCanGoSession()
            let _ = session.postLogin(txtFieldUser.text!, password: txtFieldPassw.text!)
                
                .observeOn(MainScheduler.instance)
                .subscribe { [weak self] event in
                    
                    switch event {
                    case let .Next(user):
                        if (user.email == self!.txtFieldUser.text!) {
                            
                            self!.loginSuccess()
                            // push: show services screen - change rootViewController -
                            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                            appDelegate.window?.rootViewController = appDelegate.tabBarController
                            
                        } else {
                            self!.loginNoSuccess(nil)
                        }
                        
                    case .Error (let error):
                        self!.loginNoSuccess(error as? SessionError)
                        
                    default:
                        break
                    }
            }
        }
    }
    
    @IBAction func btnForgetPASS(sender: AnyObject) {
    }
    
    @IBAction func btnNoRG(sender: AnyObject) {
    }
    
    // MARK: - Private Methods
    
    private func pushViewController() {
        
        let servicesViewController = ServicesTabViewController()
        self.presentViewController(servicesViewController, animated: true, completion: nil)
    }
    
    private func loginInProgressRequest() {
        
        loginInProgress = true
        activityIndicatorView.hidden = false
        activityIndicatorView.startAnimating()
        self.view.endEditing(true)
    }
    
    private func loginSuccess() {
        
        loginInProgress = false
        activityIndicatorView.stopAnimating()
        activityIndicatorView.hidden = true
    }
    
    private func loginNoSuccess(error: SessionError?) {
        
        var titleError = loginKoTitle
        var messageError = loginKoMessage
        
        if let error = error {
            switch error {
            case SessionError.Other(let errorDescription):
                if (errorDescription.code == -1009) {
                    titleError = noConnectionTitle
                    messageError = noConnectionMessage
                }
            default:
                break
            }
        }
        
        loginInProgress = false
        activityIndicatorView.stopAnimating()
        activityIndicatorView.hidden = true
        let alertController = UIAlertController(title: titleErr2or, message: messageError, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}


// MARK: - Extensions - Delegates

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(false)
        return true
    }
}





