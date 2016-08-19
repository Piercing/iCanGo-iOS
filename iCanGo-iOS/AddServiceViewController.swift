

import UIKit

class AddServiceViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var btnTwitterHighService: UIButton!
    @IBOutlet weak var btnFacebookHighService: UIButton!
    @IBOutlet weak var btnGooglePlusHighService: UIButton!
    @IBOutlet weak var btnLinkedinHighService: UIButton!
    @IBOutlet weak var pickerHighService: UIPickerView!
    @IBOutlet weak var labelCoinHighService: UILabel!
    @IBOutlet weak var txtFieldTitleAddService: UITextField!
    @IBOutlet weak var txtViewDescriptionAddService: UITextView!
    @IBOutlet weak var txtFieldCategoryAddService: UITextField!
    @IBOutlet weak var txtFieldPriceAddService: UITextField!
    @IBOutlet weak var txtFieldAdressAddService: UITextField!
    @IBOutlet weak var imgAddService01: UIImageView!
    @IBOutlet weak var imgAddService04: UIImageView!
    @IBOutlet weak var imgAddService03: UIImageView!
    @IBOutlet weak var imgAddService02: UIImageView!

    
    // MARK: - Constants
    let titleView = "Add Service"
    let pickerData = ["€","$","¥"]
    
    
    // MARK: - Init
    convenience init() {
        self.init(nibName: "AddServiceView", bundle: nil)
    }
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerHighService.dataSource = self
        pickerHighService.delegate = self
        
        let title = Appearance.setupUI(self.view, title: self.titleView)
        self.title = title
        Appearance.customizeAppearance(self.view)
        
        // Initialize data en view.
        setupViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Actions
    @IBAction func saveService(sender: AnyObject) {
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
    
    @IBAction func tapPhoto01(sender: UITapGestureRecognizer) {
        print("Tapped photo01")
    }
    
    @IBAction func tapPhoto02(sender: UITapGestureRecognizer) {
         print("Tapped photo02")
    }
    
    @IBAction func tapPhoto03(sender: UITapGestureRecognizer) {
         print("Tapped photo03")
    }
    
    @IBAction func tapPhoto04(sender: UITapGestureRecognizer) {
         print("Tapped photo04")
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        txtFieldTitleAddService.resignFirstResponder()
        txtViewDescriptionAddService.resignFirstResponder()
        txtFieldCategoryAddService.resignFirstResponder()
        txtFieldPriceAddService.resignFirstResponder()
        txtFieldAdressAddService.resignFirstResponder()
    }

    
    // MARK - Private Methods
    private func setupViews() {
        
        txtFieldTitleAddService.text = ""
        txtViewDescriptionAddService.text = ""
        txtFieldCategoryAddService.text = ""
        txtFieldAdressAddService.text = ""
        txtFieldPriceAddService.text = ""
        
        txtViewDescriptionAddService.layer.cornerRadius = 5
        txtViewDescriptionAddService.layer.borderColor = UIColor(named: .BorderTextFieldNormal).CGColor
        txtViewDescriptionAddService.layer.borderWidth = 0.5
    }
}


// MARK: - Extensions - UIPickerView DataSource & Delegate
extension AddServiceViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
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


// MARK: - Extensions - UITextFieldDelegate
extension AddServiceViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
    
        self.view.endEditing(true)
        return true
    }
}










