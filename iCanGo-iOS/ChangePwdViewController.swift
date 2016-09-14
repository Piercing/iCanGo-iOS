//
//  ChangePwdViewController.swift
//  iCanGo-iOS
//
//  Created by Alberto on 8/9/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit
import RxSwift

class ChangePwdViewController: UIViewController {
    
    
    // MARK: - Properties
    @IBOutlet weak var oldPwdText: UITextField!
    @IBOutlet weak var newPwdText: UITextField!
    @IBOutlet weak var confirmPwdText: UITextField!
    
    private var user: User!
    private var requestDataInProgress: Bool = false
    
    lazy var alertView: AlertView = {
        let alertView = AlertView()
        return alertView
    }()
    
    
    // MARK: - Init
    convenience init(user: User) {
        
        self.init(nibName: "ChangePwdView", bundle: nil)
        
        // Initialize variables.
        self.user = user
    }
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = Appearance.setupUI(self.view, title: changePasswordVC)
        
        // Initialize data en view.
        setupViews()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isConnectedToNetwork() {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
            return
        }
        
        oldPwdText.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Actions
    @IBAction func cancelButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        
        resignFirstResponderAllFields()
        
        if !self.pwdDataWithErrorData() {
            
            // Validate all data.
            let okAction = UIAlertAction(title: ok, style: .Default, handler:{ (action: UIAlertAction!) in
                self.validateOldPwd()
            })
            let cancelAction = UIAlertAction(title: cancel, style: .Cancel, handler: nil)
            let actions = [okAction, cancelAction]
            showAlertWithActions(userChangePwdTitle, message: userChangePwdConfirmationMessage, controller: self, actions: actions)
        }
    }
    
    
    // MARK: - Private Methods
    private func setupViews() {
        
        oldPwdText.text = ""
        newPwdText.text = ""
        confirmPwdText.text = ""
        
        let arrayBordersViews = [oldPwdText,
                                 newPwdText,
                                 confirmPwdText]
        
        bordersInViews(arrayBordersViews)
        
        let oldPwdTextTextActions: [String : Selector] = [next : #selector(ChangePwdViewController.nextOldPwdText),
                                                            ok : #selector(ChangePwdViewController.okOldPwdText)]
        let newPwdTextTextActions: [String : Selector] = [next : #selector(ChangePwdViewController.nextNewPwdText),
                                                            ok : #selector(ChangePwdViewController.okNewPwdText)]
        let confirmPwdTextActions: [String : Selector] = [ok : #selector(ChangePwdViewController.okConfirmPwdText)]
        
        oldPwdText.inputAccessoryView = setupInputAccessoryView(oldPwdTextTextActions)
        newPwdText.inputAccessoryView = setupInputAccessoryView(newPwdTextTextActions)
        confirmPwdText.inputAccessoryView = setupInputAccessoryView(confirmPwdTextActions)
    }
    
    private func validateOldPwd() -> Void {
        
        if !isConnectedToNetwork()  {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
            return
        }
        
        if requestDataInProgress {
            showAlert(userChangePwdTitle, message: apiConnectionNoPossible, controller: self)
            return
        }
        
        requestDataInProgress = true
        alertView.displayView(view, withTitle: pleaseWait)
        
        let session = Session.iCanGoSession()
        let _ = session.postLogin(user.email, password: oldPwdText.text!)
            
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                
                self!.alertView.hideView()
                self?.requestDataInProgress = false
                
                switch event {
                case let .Next(user):
                    
                    if self?.user.id == user.id {
                        self!.changePwd()
                    } else {
                        showAlert(userChangePwdTitle, message: userChangePwdNoOldPwd, controller: self!)
                    }
     
                case .Error (let error):
                    showAlert(userChangePwdTitle, message: userChangePwdNoOldPwd, controller: self!)
                    print(error)
                    
                default:
                    break
                }
        }
    }

    private func changePwd() -> Void {
        
        if !isConnectedToNetwork()  {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
            return
        }
        
        if requestDataInProgress {
            showAlert(userChangePwdTitle, message: apiConnectionNoPossible, controller: self)
            return
        }
        
        requestDataInProgress = true
        alertView.displayView(view, withTitle: pleaseWait)
        
        let session = Session.iCanGoSession()
        let _ = session.putUser(user.id, firstName: nil, lastName: nil, email: user.email, searchPreferences: nil,
            oldPassword: oldPwdText.text, newPassword: newPwdText.text, photoUrl: nil)
            
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                
                self!.alertView.hideView()
                self?.requestDataInProgress = false
                
                switch event {
                case let .Next(user):
                    
                    if self?.user.id == user.id {

                        let okAction = UIAlertAction(title: ok, style: .Default, handler:{ (action: UIAlertAction!) in

                            logoutUser()
                            let loginVC = LoginViewController()
                            loginVC.delegate = self
                            loginVC.selectedTabItemIndex = self!.tabBarController!.viewControllers?.indexOf(self!)
                            showModal(self!, calledContainer: loginVC)
                        })
                        let actions = [okAction]
                        showAlertWithActions(userChangePwdTitle, message: userChangePwdMessage, controller: self!, actions: actions)
                        
                    } else {
                        showAlert(userChangePwdTitle, message: userChangePwdKOMessage, controller: self!)
                    }
                    
                case .Error (let error):
                    showAlert(userChangePwdTitle, message: userChangePwdKOMessage, controller: self!)
                    print(error)
                    
                default:
                    break
                }
        }
    }
    
    private func bordersInViews(views: [UITextField!]) {
        
        for view in views {
            view.layer.cornerRadius = 5
            view.layer.borderColor = UIColor(named: .BorderTextFieldNormal).CGColor
            view.layer.borderWidth = 0.5
        }
    }
    
    private func setupInputAccessoryView(actions: [String : Selector])-> UIToolbar {
        
        let toolBar = UIToolbar()
        toolBar.translucent = true
        toolBar.tintColor = UIColor(named: .TextColor1)
        
        var nextButton: UIBarButtonItem = UIBarButtonItem()
        var okButton: UIBarButtonItem = UIBarButtonItem()
        if let nextSelector = actions[next] {
            nextButton = UIBarButtonItem(title: next, style: UIBarButtonItemStyle.Plain, target: self, action: nextSelector)
        }
        if let okSelector = actions[ok] {
            okButton = UIBarButtonItem(title: ok, style: UIBarButtonItemStyle.Plain, target: self, action: okSelector)
        }
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, okButton, nextButton], animated: false)
        toolBar.userInteractionEnabled = true
        toolBar.sizeToFit()
        return toolBar
    }
    
    @objc private func nextOldPwdText() {
        newPwdText.becomeFirstResponder()
    }
    
    @objc private func okOldPwdText() {
        oldPwdText.resignFirstResponder()
    }
    
    @objc private func nextNewPwdText() {
        confirmPwdText.becomeFirstResponder()
    }
    
    @objc private func okNewPwdText() {
        newPwdText.resignFirstResponder()
    }
    
    @objc private func okConfirmPwdText() {
        confirmPwdText.resignFirstResponder()
    }
    
    private func pwdDataWithErrorData() -> Bool {
        
        var findError = false
        
        if oldPwdText.text == "" {
            
            if !findError { oldPwdText.becomeFirstResponder() }
            oldPwdText.layer.borderColor = UIColor(named: .BorderTextFieldError).CGColor
            findError = true
        } else {
            oldPwdText.layer.borderColor = UIColor(named: .BorderTextFieldNormal).CGColor
        }
        
        if newPwdText.text == "" {
            
            if !findError { newPwdText.becomeFirstResponder() }
            newPwdText.layer.borderColor = UIColor(named: .BorderTextFieldError).CGColor
            findError = true
        } else {
            newPwdText.layer.borderColor = UIColor(named: .BorderTextFieldNormal).CGColor
        }
        
        if confirmPwdText.text == "" {
            
            if !findError { confirmPwdText.becomeFirstResponder() }
            confirmPwdText.layer.borderColor = UIColor(named: .BorderTextFieldError).CGColor
            findError = true
        } else {
            confirmPwdText.layer.borderColor = UIColor(named: .BorderTextFieldNormal).CGColor
        }
        
        if findError {
            showAlert(userChangePwdTitle, message: userChangePwdFieldEmply, controller: self)
            return findError
        }
        
        if newPwdText.text!.characters.count < 8 {
            
            showAlert(userChangePwdTitle, message: userChangePwdNewCharacters, controller: self)
            return findError
        }
        
        if newPwdText.text != confirmPwdText.text {
            
            showAlert(userChangePwdTitle, message: userChangePwdNewConfirm, controller: self)
            return findError
        }
        
        if oldPwdText.text == newPwdText.text {
            
            showAlert(userChangePwdTitle, message: userChangePwdDifferent, controller: self)
            return findError
        }

        return findError
    }
    
    private func resignFirstResponderAllFields() {
        
        oldPwdText.resignFirstResponder()
        newPwdText.resignFirstResponder()
        confirmPwdText.resignFirstResponder()
    }
}


// MARK: - Extensions - Delegate Methods
extension ChangePwdViewController: ComunicationLoginControllerDelegate {
    
    func back(index: Int) {
        
        if isUserloged() {
            self.navigationController?.popViewControllerAnimated(true)
        } else {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
}






