//
//  MyProfileEditViewController.swift
//  iCanGo-iOS
//
//  Created by Alberto on 7/9/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit
import RxSwift

protocol MyProfileEditControllerDelegate {
    func back(user: User, endSession: Bool)
}


class MyProfileEditViewController: UIViewController, UIAlertViewDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var userFirstNameText: UITextField!
    @IBOutlet weak var userLastNameText: UITextField!
    @IBOutlet weak var userPasswordText: UITextField!
    @IBOutlet weak var userImageView: CircularImageView!
    @IBOutlet weak var userEndSession: UIButton!
    var delegate: MyProfileEditControllerDelegate? = nil
    
    private var user: User!
    private var requestDataInProgress: Bool = false
    private var changeProfilePhoto: Bool = false
    private var imagePicker:UIImagePickerController? = UIImagePickerController()
    
    lazy var alertView: AlertView = {
        let alertView = AlertView()
        return alertView
    }()
    
    
    // MARK: - Init
    convenience init(user: User) {
        
        self.init(nibName: "MyProfileEditView", bundle: nil)
        
        // Initialize variables.
        self.user = user
    }
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = Appearance.setupUI(self.view, title: myProfileTitleVC)
        
        // Delegate
        userPasswordText.delegate = self
        
        // Initialize data en view.
        setupViews()
        
        // Get data from API.
        loadUser(user.id)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isConnectedToNetwork() {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Actions
    @IBAction func cancelButton(sender: AnyObject) {
        
        let slideDownUpTransition = CATransition()
        slideDownUpTransition.type = kCATransitionMoveIn
        slideDownUpTransition.subtype = kCATransitionFromBottom
        slideDownUpTransition.duration = 0.3
        self.navigationController?.view.layer.addAnimation(slideDownUpTransition, forKey: kCATransition)
        self.navigationController?.popToRootViewControllerAnimated(false)
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        
        resignFirstResponderAllFields()
        
        if !self.profileDataWithErrorData() {
            
            // Validate all data.
            let okAction = UIAlertAction(title: ok, style: .Default, handler:{ (action: UIAlertAction!) in
                
                if self.changeProfilePhoto {
                    // Upgrade photo profile, and after, upgrade its urls and rest data.
                    //self.putPhotoProfile()
                
                
                
                
                
                
                
                
                
                } else {
                    // Upgrade user data.
                    self.putDataUser()
                }
            })
            let cancelAction = UIAlertAction(title: cancel, style: .Cancel, handler: nil)
            let actions = [okAction, cancelAction]
            showAlertWithActions(userProfileTitle, message: userProfileConfirmationMessage, controller: self, actions: actions)
        }
    }
    
    @IBAction func endSession(sender: AnyObject) {
        
        // Confirm Logout.
        let okAction = UIAlertAction(title: ok, style: .Default, handler:{ (action: UIAlertAction!) in
            
            logoutUser()
            saveAuthInfo(self.user)
            if self.delegate != nil {
                self.delegate?.back(self.user, endSession: true)
            }
        })
        let cancelAction = UIAlertAction(title: cancel, style: .Cancel, handler: nil)
        let actions = [okAction, cancelAction]
        showAlertWithActions(userProfileTitle, message: userProfileConfirmLogoutMessage, controller: self, actions: actions)
    }
    
    @IBAction func changePhotoProfile(sender: AnyObject) {
        
        let alert: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cameraAction = UIAlertAction(title: alertCameraTakePhoto, style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.openCamera()
        }
        
        let galleryAction = UIAlertAction(title: alertCameraSelectPhoto, style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.openGallery()
        }
        
        let cancelAction = UIAlertAction(title: cancel, style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
        }
        
        // Add the actions
        imagePicker?.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        
        userFirstNameText.text = ""
        userLastNameText.text = ""
        userPasswordText.text = ""
        
        let arrayBordersViews = [userFirstNameText,
                                 userLastNameText]
        
        bordersInViews(arrayBordersViews)
        
        let userFirstNameTextActions: [String : Selector] = [next : #selector(MyProfileEditViewController.nextFirstName),
                                                             ok : #selector(MyProfileEditViewController.okFirstName)]
        let userLastNameTextActions: [String : Selector] = [ok : #selector(MyProfileEditViewController.okLastName)]
        userFirstNameText.inputAccessoryView = setupInputAccessoryView(userFirstNameTextActions)
        userLastNameText.inputAccessoryView = setupInputAccessoryView(userLastNameTextActions)
    }
    
    private func loadUser(id: String) -> Void {
        
        if !isConnectedToNetwork()  {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
            return
        }
        
        if requestDataInProgress {
            showAlert(userProfileTitle, message: apiConnectionNoPossible, controller: self)
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
                    showAlert(userProfileTitle, message: serviceGetUserKO, controller: self!)
                    print(error)
                    
                default:
                    break
                }
        }
        
    }
    
    private func showDataUser() {
        
        // Show data user.
        userFirstNameText.text = user.firstName
        userLastNameText.text = user.lastName
        userPasswordText.text = "********"
        
        if let photo = user.photoURL {
            loadImage(photo, imageView: userImageView, withAnimation: false)
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
    
    @objc private func nextFirstName() {
        userLastNameText.becomeFirstResponder()
    }
    
    @objc private func okFirstName() {
        userFirstNameText.resignFirstResponder()
    }
    
    @objc private func okLastName() {
        userLastNameText.resignFirstResponder()
    }
    
    private func profileDataWithErrorData() -> Bool {
        
        var findError = false
        
        if userFirstNameText.text == "" {
            
            if !findError { userFirstNameText.becomeFirstResponder() }
            userFirstNameText.layer.borderColor = UIColor(named: .BorderTextFieldError).CGColor
            findError = true
        } else {
            userFirstNameText.layer.borderColor = UIColor(named: .BorderTextFieldNormal).CGColor
        }
        
        if userLastNameText.text == "" {
            
            if !findError { userLastNameText.becomeFirstResponder() }
            userLastNameText.layer.borderColor = UIColor(named: .BorderTextFieldError).CGColor
            findError = true
        } else {
            userLastNameText.layer.borderColor = UIColor(named: .BorderTextFieldNormal).CGColor
        }
        
        if findError {
            showAlert(userProfileTitle, message: userProfileFieldEmply, controller: self)
            return findError
        }
        
        if userFirstNameText.text == user.firstName &&
            userLastNameText.text == user.lastName {
            
            showAlert(userProfileTitle, message: userProfileNoModification, controller: self)
            findError = true
        }
        
        return findError
    }
    
    private func resignFirstResponderAllFields() {
        
        userFirstNameText.resignFirstResponder()
        userLastNameText.resignFirstResponder()
    }
    
    private func putDataUser() -> Void {
        
        if !isConnectedToNetwork()  {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
            return
        }
        
        if requestDataInProgress {
            showAlert(userProfileTitle, message: apiConnectionNoPossible, controller: self)
            return
        }
        
        requestDataInProgress = true
        alertView.displayView(view, withTitle: pleaseWait)
        
        // Only inform those parameters that has changed
        let session = Session.iCanGoSession()
        let _ = session.putUser(user.id,
            firstName: user.firstName != userFirstNameText.text ? userFirstNameText.text : nil,
            lastName: user.lastName != userLastNameText ? userLastNameText.text : nil,
            email: nil,
            searchPreferences: nil,
            oldPassword: nil,
            newPassword: nil,
            photoUrl: changeProfilePhoto ? user.photoURL : nil)
            
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                
                self!.alertView.hideView()
                self?.requestDataInProgress = false
                
                switch event {
                case let .Next(user):
                    
                    if self?.user.id == user.id {
                        
                        let okAction = UIAlertAction(title: ok, style: .Default, handler:{ (action: UIAlertAction!) in
                            
                            logoutUser()
                            saveAuthInfo(self!.user)
                            if self!.delegate != nil {
                                self!.delegate?.back(self!.user, endSession: false)
                            }
                        })
                        let actions = [okAction]
                        showAlertWithActions(userProfileTitle, message: userProfileMessage, controller: self!, actions: actions)
                        
                    } else {
                        showAlert(userProfileTitle, message: userProfileKOMessage, controller: self!)
                    }
                    
                case .Error (let error):
                    showAlert(userProfileTitle, message: userProfileKOMessage, controller: self!)
                    print(error)
                    
                default:
                    break
                }
        }
    }
    
    func openCamera() {
        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            
            imagePicker!.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(imagePicker!, animated: true, completion: nil)
        } else {
            openGallery()
        }
    }
    
    func openGallery() {
        
        imagePicker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker!, animated: true, completion: nil)
    }
    
    /*
    private func putPhotoProfile() -> Void {
        
        if !isConnectedToNetwork()  {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
            return
        }
        
        if requestDataInProgress {
            showAlert(userProfileTitle, message: apiConnectionNoPossible, controller: self)
            return
        }
        
        requestDataInProgress = true
        alertView.displayView(view, withTitle: pleaseWait)
        
        // Only inform those parameters that has changed
        let session = Session.iCanGoSession()
        let _ = session.putUser()
            
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                
                self!.alertView.hideView()
                self?.requestDataInProgress = false
                
                switch event {
                case let .Next(user):
                    
                    
                    
                    
                    
                    
                    
                    
                    //                self.putDataUser()
                    
                    
                    
                    
                    
                    
                    
                    if self?.user.id == user.id {
                        
                        let okAction = UIAlertAction(title: ok, style: .Default, handler:{ (action: UIAlertAction!) in
                            
                            logoutUser()
                            saveAuthInfo(self!.user)
                            if self!.delegate != nil {
                                self!.delegate?.back(self!.user, endSession: false)
                            }
                        })
                        let actions = [okAction]
                        showAlertWithActions(userProfileTitle, message: userProfileMessage, controller: self!, actions: actions)
                        
                    } else {
                        showAlert(userProfileTitle, message: userProfileKOMessage, controller: self!)
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                case .Error (let error):
                    showAlert(userProfileTitle, message: userProfileKOMessage, controller: self!)
                    print(error)
                    
                default:
                    break
                }
        }
    }
    */
    
}


// MARK: - Extensions - UITextFieldDelegate
extension MyProfileEditViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if textField == userPasswordText {
            let changePwdViewController = ChangePwdViewController(user: user)
            self.navigationController?.pushViewController(changePwdViewController, animated: true)
            return false
        }
        return true
    }
}


// MARK: - Extensions - UITextFieldDelegate
extension MyProfileEditViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        picker .dismissViewControllerAnimated(true, completion: nil)
        var originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        // Resize and reduced profile user photo.
        let imageReducedAndResized: NSData = originalImage!.reducedImage()
        originalImage = nil
        
        // New image profile user.
        userImageView.image = UIImage(data: imageReducedAndResized)
        changeProfilePhoto = true
    }
}