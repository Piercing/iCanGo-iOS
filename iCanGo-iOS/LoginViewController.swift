//
//  LoginViewController.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 23/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit
import RxSwift

protocol ComunicationLoginControllerDelegate {
    func back(index: Int)
}

class LoginViewController: UIViewController {
    
    var selectedTabItemIndex: Int?
    var delegate: ComunicationLoginControllerDelegate? = nil
    
    // MARK: - Properties
    
    @IBOutlet weak var txtFieldUser: UITextField!
    @IBOutlet weak var txtFieldPassw: UITextField!
    @IBOutlet weak var btnInitSession: UIButton!
    @IBOutlet weak var btnForgetPassw: UIButton!
    @IBOutlet weak var btnNotRegister: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var loginInProgress: Bool!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView.hidden = true
        loginInProgress = false
        
        setupUI()
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        // TODO: This should be in a theme class
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
                        saveAuthInfo(user)
                        self!.close()
                        break
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
    
    @IBAction func cancelTapped(sender: AnyObject) {
        close()
    }
    
    func close() -> Void {
        self.delegate?.back(selectedTabItemIndex!);
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Methods
    
    func setupUI() {
        Appearance.customizeAppearance(self.view)
    }
    
    // MARK: - Private Methods
    
//    private func pushViewController() {
//        
//        let servicesViewController = ServicesViewController()
//        self.presentViewController(servicesViewController, animated: true, completion: nil)
//    }
    
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
        let alertController = UIAlertController(title: titleError, message: messageError, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}


// MARK: - Extensions - Delegates

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}







