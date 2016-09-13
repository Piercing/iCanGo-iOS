

import UIKit
import MapKit
import RxSwift

class AddServiceViewController: UIViewController {
    
    // MARK: - Constants
    let serviceId = "serviceId"
    
    
    // MARK: - Properties
//    @IBOutlet weak var btnTwitterHighService: UIButton!
//    @IBOutlet weak var btnFacebookHighService: UIButton!
//    @IBOutlet weak var btnLinkedinHighService: UIButton!
    @IBOutlet weak var labelCoinHighService: UILabel!
    @IBOutlet weak var txtFieldTitleAddService: UITextField!
    @IBOutlet weak var txtViewDescriptionAddService: UITextView!
    @IBOutlet weak var txtFieldCategoryAddService: UITextField!
    @IBOutlet weak var txtFieldPriceAddService: UITextField!
    @IBOutlet weak var txtFieldAdressAddService: UITextField!
//    @IBOutlet weak var imgAddService01: UIImageView!
//    @IBOutlet weak var imgAddService04: UIImageView!
//    @IBOutlet weak var imgAddService03: UIImageView!
//    @IBOutlet weak var imgAddService02: UIImageView!
    
    private var locationManager: CLLocationManager?
    private var statusLocation: CLAuthorizationStatus?
    private var myPosition: CLLocation?
    private var requestDataInProgress: Bool = false
    private var numberUpdatesPosition: UInt = 0
    
    lazy var alertView: AlertView = {
        let alertView = AlertView()
        return alertView
    }()
    
    
    // MARK: - Init
    convenience init() {
        self.init(nibName: "AddServiceView", bundle: nil)
    }
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Appearance.setupUI(self.view, title: addServiceTitleVC)
        Appearance.customizeAppearance(self.view)
        
        // Configure Location Manager.
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()
        
        // Initialize data en view.
        setupViews()
    }
    
    override func viewWillAppear(animated: Bool) {
        initializeInfoService() 
        checkLocationStatus()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Actions
    @IBAction func saveService(sender: AnyObject) {
        
        resignFirstResponderAllFields()
        
        if !self.serviceWithErrorData() {
            
            // Validate all data.
            let okAction = UIAlertAction(title: ok, style: .Default, handler:{ (action: UIAlertAction!) in
                self.postDataService()
            })
            let cancelAction = UIAlertAction(title: cancel, style: .Cancel, handler: nil)
            let actions = [okAction, cancelAction]
            showAlertWithActions(serviceAddTitle, message: serviceAddConfirmationMessage, controller: self, actions: actions)
        }
    }
    
    //    @IBAction func twitterHighServiceAction(sender: AnyObject) {
    //        print("Tapped buttom Twitter")
    //    }
    //    
    //    @IBAction func facebookHighServiceAction(sender: AnyObject) {
    //        print("Tapped buttom Facebook")
    //    }
    //    
    //    @IBAction func linkedinHighServicesAction(sender: AnyObject) {
    //        print("Tapped buttom Linkedin")
    //    }
    //    
    //    @IBAction func tapPhoto01(sender: UITapGestureRecognizer) {
    //        print("Tapped photo01")
    //    }
    //    
    //    @IBAction func tapPhoto02(sender: UITapGestureRecognizer) {
    //         print("Tapped photo02")
    //    }
    //    
    //    @IBAction func tapPhoto03(sender: UITapGestureRecognizer) {
    //         print("Tapped photo03")
    //    }
    //    
    //    @IBAction func tapPhoto04(sender: UITapGestureRecognizer) {
    //         print("Tapped photo04")
    //    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        resignFirstResponderAllFields()
    }
    
    @IBAction func btn_shared(sender: AnyObject) {
        
        let nameServiceToShare = txtFieldTitleAddService.text
        let textToshare = txtViewDescriptionAddService.text
        let priceToShare = txtFieldPriceAddService.text
        let addressUserToShare = txtFieldAdressAddService.text
        let objetsToShare = [nameServiceToShare, textToshare, priceToShare, addressUserToShare]
        let activityVC = UIActivityViewController(activityItems: objetsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityTypeAddToReadingList]
        activityVC.popoverPresentationController?.sourceView = sender as? UIView
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    // MARK - Private Methods
    private func setupViews() {
        
        initializeInfoService()
        
        let arrayBordersViews = [txtFieldTitleAddService,
                                 txtViewDescriptionAddService,
                                 txtFieldCategoryAddService,
                                 txtFieldAdressAddService,
                                 txtFieldPriceAddService]
        
        bordersInViews(arrayBordersViews)
        
        let titleActions: [String : Selector] = [next : #selector(AddServiceViewController.nextTitle),
                                                 ok : #selector(AddServiceViewController.okTitle)]
        let descriptionActions: [String : Selector] = [next : #selector(AddServiceViewController.nextDescription),
                                                       ok : #selector(AddServiceViewController.okDescription)]
        let categoryActions: [String : Selector] = [next : #selector(AddServiceViewController.nextCategory),
                                                    ok : #selector(AddServiceViewController.okCategory)]
        let addressActions: [String : Selector] = [next : #selector(AddServiceViewController.nextAddress),
                                                   ok : #selector(AddServiceViewController.okAdress)]
        let priceActions: [String : Selector] = [ok : #selector(AddServiceViewController.okPrice)]
        
        txtFieldTitleAddService.inputAccessoryView = setupInputAccessoryView(titleActions)
        txtViewDescriptionAddService.inputAccessoryView = setupInputAccessoryView(descriptionActions)
        txtFieldCategoryAddService.inputAccessoryView = setupInputAccessoryView(categoryActions)
        txtFieldAdressAddService.inputAccessoryView = setupInputAccessoryView(addressActions)
        txtFieldPriceAddService.inputAccessoryView = setupInputAccessoryView(priceActions)
    }
    
    private func initializeInfoService() {
        
        txtFieldTitleAddService.text = ""
        txtViewDescriptionAddService.text = ""
        txtFieldCategoryAddService.text = ""
        txtFieldAdressAddService.text = ""
        txtFieldPriceAddService.text = ""
    }
    
    private func bordersInViews(views: [UIView]) {
        
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
    
    @objc private func nextTitle() {
        txtViewDescriptionAddService.becomeFirstResponder()
    }
    
    @objc private func okTitle() {
        txtFieldTitleAddService.resignFirstResponder()
    }
    
    @objc private func nextDescription() {
        txtFieldCategoryAddService.becomeFirstResponder()
    }
    
    @objc private func okDescription() {
        txtViewDescriptionAddService.resignFirstResponder()
    }
    
    @objc private func nextCategory() {
        txtFieldAdressAddService.becomeFirstResponder()
    }
    
    @objc private func okCategory() {
        txtFieldCategoryAddService.resignFirstResponder()
    }
    
    @objc private func nextAddress() {
        txtFieldPriceAddService.becomeFirstResponder()
    }
    
    @objc private func okAdress() {
        txtFieldAdressAddService.resignFirstResponder()
    }
    
    @objc private func okPrice() {
        txtFieldPriceAddService.resignFirstResponder()
    }
    
    private func checkLocationStatus() {
        
        guard let status = statusLocation else {
            return
        }
        
        if status == .NotDetermined {
            locationManager?.requestWhenInUseAuthorization()
            return
        }
        
        if status != .AuthorizedAlways && status != .AuthorizedWhenInUse {
            showAlert(noGeoUserTitle, message: noGeoUserMessage, controller: self)
        }
    }
    
    private func serviceWithErrorData() -> Bool {
        
        var findError = false
        
        if txtFieldTitleAddService.text == "" {
            
            if !findError { txtFieldTitleAddService.becomeFirstResponder() }
            txtFieldTitleAddService.layer.borderColor = UIColor(named: .BorderTextFieldError).CGColor
            findError = true
        } else {
            txtFieldTitleAddService.layer.borderColor = UIColor(named: .BorderTextFieldNormal).CGColor
        }
        
        if txtViewDescriptionAddService.text == "" {
            
            if !findError { txtViewDescriptionAddService.becomeFirstResponder() }
            txtViewDescriptionAddService.layer.borderColor = UIColor(named: .BorderTextFieldError).CGColor
            findError = true
        } else {
            txtViewDescriptionAddService.layer.borderColor = UIColor(named: .BorderTextFieldNormal).CGColor
        }
        
        if txtFieldCategoryAddService.text == "" {
            
            if !findError { txtFieldCategoryAddService.becomeFirstResponder() }
            txtFieldCategoryAddService.layer.borderColor = UIColor(named: .BorderTextFieldError).CGColor
            findError = true
        } else {
            txtFieldCategoryAddService.layer.borderColor = UIColor(named: .BorderTextFieldNormal).CGColor
        }
        
        if myPosition == nil {
            if txtFieldAdressAddService.text == "" {
                
                if !findError { txtFieldAdressAddService.becomeFirstResponder() }
                txtFieldAdressAddService.layer.borderColor = UIColor(named: .BorderTextFieldError).CGColor
                findError = true
            } else {
                txtFieldAdressAddService.layer.borderColor = UIColor(named: .BorderTextFieldNormal).CGColor
            }
        }
        
        if txtFieldPriceAddService.text == "" {
            
            if !findError { txtFieldPriceAddService.becomeFirstResponder() }
            txtFieldPriceAddService.layer.borderColor = UIColor(named: .BorderTextFieldError).CGColor
            findError = true
        } else {
            txtFieldPriceAddService.layer.borderColor = UIColor(named: .BorderTextFieldNormal).CGColor
        }
        
        if findError {
            showAlert(serviceAddTitle, message: serviceAddFieldEmply, controller: self)
        }
        
        return findError
    }
    
    private func postDataService() {
        
        if !isConnectedToNetwork() {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
            return
        }
        
        if requestDataInProgress {
            return
        }
        
        requestDataInProgress = true
        alertView.displayView(view, withTitle: pleaseWait)
        
        let session = Session.iCanGoSession()
        let _ = session.postService(txtFieldTitleAddService.text!,
            description: txtViewDescriptionAddService.text,
            price: Double(txtFieldPriceAddService.text!.stringByReplacingOccurrencesOfString(",", withString: "."))!,
            tags: txtFieldCategoryAddService.text,
            idUserRequest: loadUserAuthInfo().id,
            latitude: myPosition?.coordinate.latitude,
            longitude: myPosition?.coordinate.longitude,
            address: txtFieldAdressAddService.text,
            status: 0)
            
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                
                switch event {
                case let .Next(service):
                    self!.alertView.hideView()
                    self?.requestDataInProgress = false
                    
                    let okAction = UIAlertAction(title: ok, style: .Default, handler:{ (action: UIAlertAction!) in
                        
                        NSNotificationCenter.defaultCenter().postNotificationName(notificationKeyServicesChange,
                            object: self, userInfo: [self!.serviceId: service.id])
                        
                        self!.tabBarController!.selectedIndex = 0
                    })
                    let actions = [okAction]
                    showAlertWithActions(serviceAddTitle, message: serviceAddMessage, controller: self!, actions: actions)
                    
                case .Error (let error):
                    self!.alertView.hideView()
                    self?.requestDataInProgress = false
                    showAlert(serviceAddTitle, message: serviceAddKOMessage, controller: self!)
                    print(error)
                    
                default:
                    self!.alertView.hideView()
                    self?.requestDataInProgress = false
                }
        }
    }
    
    private func resignFirstResponderAllFields() {
        
        txtFieldTitleAddService.resignFirstResponder()
        txtViewDescriptionAddService.resignFirstResponder()
        txtFieldCategoryAddService.resignFirstResponder()
        txtFieldPriceAddService.resignFirstResponder()
        txtFieldAdressAddService.resignFirstResponder()
    }
}


// MARK: - Extension - CLLocationManagerDelegate
extension AddServiceViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        statusLocation = status
        checkLocationStatus()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if (numberUpdatesPosition < maxUpdatesPosition) {
            
            myPosition = locations.last
            numberUpdatesPosition += 1
        } else {
            locationManager?.stopUpdatingLocation()
        }
    }
}






// MARK: - Extensions - UITextFieldDelegate
//extension AddServiceViewController: UITextFieldDelegate {
//    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//    
//        self.view.endEditing(true)
//        return true
//    }
//}











