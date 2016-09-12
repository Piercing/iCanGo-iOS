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
    
    let titleView = "Login"
    var selectedTabItemIndex: Int?
    var delegate: ComunicationLoginControllerDelegate? = nil
    
    // MARK: - Properties
    @IBOutlet weak var iCanGoLogIn: UIImageView!
    @IBOutlet weak var txtFieldUser: UITextField!
    @IBOutlet weak var txtFieldPassw: UITextField!
    @IBOutlet weak var btnInitSession: UIButton!
    @IBOutlet weak var btnForgetPassw: UIButton!
    @IBOutlet weak var btnNotRegister: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private var loginInProgress: Bool!
    
    
    // MARK: - Init
    convenience init() {
        self.init(nibName: "LoginView", bundle: nil)
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView.hidden = true
        loginInProgress = false
        
        btnInitSession.enabled = false
        
        Appearance.setupUI(self.view, title: self.titleView)
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        
        // TODO: This should be in a theme class
        txtFieldUser.layer.cornerRadius = 5
        txtFieldPassw.layer.cornerRadius = 5
        btnInitSession.layer.cornerRadius = 5
        iCanGoLogIn.layer.cornerRadius = 5
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
    @IBAction func doLogin(sender: AnyObject) {
        login()
    }
    
    func login() -> Void {
        // Check info of login fields.
        if (txtFieldUser.text != "" && txtFieldPassw.text != "" && !loginInProgress) {
            
            self.view.endEditing(true)
            loginInProgress = actionStarted(activityIndicatorView)
            
            let session = Session.iCanGoSession()
            let _ = session.postLogin(txtFieldUser.text!, password: txtFieldPassw.text!)
                
                .observeOn(MainScheduler.instance)
                .subscribe { [weak self] event in
                    
                    switch event {
                    case let .Next(user):
                        saveAuthInfo(user)
                        self!.loginInProgress = actionFinished(self!.activityIndicatorView)
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
        openRecoverPassView()
    }
    
    @IBAction func btnNoRG(sender: AnyObject) {
        
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        close()
    }
    
    // MARK: Methods
    
    func openRecoverPassView(){
        var recoverPassVC = RecoverPassViewController()
        recoverPassVC = RecoverPassViewController(nibName: "RecoverPassView", bundle: nil)
        self.presentViewController(recoverPassVC, animated: true, completion: nil)
    }
    
    func close() -> Void {
        self.delegate?.back(selectedTabItemIndex!);
        self.dismissViewControllerAnimated(true, completion: nil)
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
        
        loginInProgress = actionFinished(activityIndicatorView)
        showAlert(titleError, message: messageError, controller: self)
    }
}


// MARK: - Extensions - Delegates

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        btnInitSession.enabled = txtFieldUser.text != "" && txtFieldPassw.text != "" && !loginInProgress
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        btnInitSession.enabled = txtFieldUser.text != "" && txtFieldPassw.text != "" && !loginInProgress
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        btnInitSession.enabled = txtFieldUser.text != "" && txtFieldPassw.text != "" && !loginInProgress
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        btnInitSession.enabled = txtFieldUser.text != "" && txtFieldPassw.text != "" && !loginInProgress
        return true
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        btnInitSession.enabled = txtFieldUser.text != "" && txtFieldPassw.text != "" && !loginInProgress
        return true
    }
}








