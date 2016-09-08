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
    
    //private var user: User!
    //private var requestDataInProgress: Bool = false
    
    lazy var alertView: AlertView = {
        let alertView = AlertView()
        return alertView
    }()
    
    
    // MARK: - Init
    convenience init(user: User) {
        
        self.init(nibName: "ChangePwdView", bundle: nil)
        
        // Initialize variables.
        //self.user = user
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
        
        // Get data from API.
        //loadUser(user.id)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Actions
    @IBAction func cancelButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        
    }
    
    
    // MARK: - Private Methods
    private func setupViews() {
        
        //userFirstNameText.text = ""
        //userLastNameText.text = ""
        //userPasswordText.text = ""
    }
    
    /*
    private func loadUser(id: String) -> Void {
        
        if !isConnectedToNetwork()  {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
            return
        }
        
        if requestDataInProgress {
            return
        }
        
        requestDataInProgress = true
        alertView.displayView(view, withTitle: pleaseWait)
        
        let session = Session.iCanGoSession()
        let _ = session.getUserById(user.id)
            
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                
                self!.alertView.hideView()
                self?.requestDataInProgress = false
                
                switch event {
                case let .Next(user):
                    self?.user = user
                    self?.showDataUser()
                    
                case .Error (let error):
                    print(error)
                    
                default:
                    break
                }
        }
        
    }
    */
    
    private func showDataUser() {
        
        // Show data user.
        //userFirstNameText.text = user.firstName
        //userLastNameText.text = user.lastName
        //userPasswordText.text = "********"
        
        //if let photo = user.photoURL {
        //    loadImage(photo, imageView: userImageView, withAnimation: false)
        //}
    }
}