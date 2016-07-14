

import UIKit

class UserRegisterViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var txtFieldUserResgister: UITextField!
    @IBOutlet weak var txtFieldUserPass: UITextField!
    @IBOutlet weak var btnRegisterWithEmail: UIButton!
    @IBOutlet weak var btnRegisterWithTwitter: UIButton!
    @IBOutlet weak var btnRegisterWithFacebook: UIButton!
    @IBOutlet weak var btnRegisterWithGooglePlus: UIButton!
    @IBOutlet weak var btnPrivtePolicyRegisterUser: UIButton!
    
    let titleView = "User register"
    
    // MARK: - Init
    convenience init() {
        self.init(nibName: "UserRegisterView", bundle: nil)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - UI
        let title = Appearance.setupUI(self.view, title: self.titleView)
        self.title = title
        Appearance.customizeAppearance(self.view)
        Appearance.addDidLayoutSubviewsFourButtons(
            btnRegisterWithEmail,
            btn2: btnRegisterWithTwitter,
            btn3: btnRegisterWithFacebook,
            btn4: btnRegisterWithGooglePlus)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        txtFieldUserResgister.resignFirstResponder()
        txtFieldUserPass.resignFirstResponder()
    }
    
    // MARK: - Actions
    
    @IBAction func btnBackRegisterUser(sender: AnyObject) {
        print("Tapped button Back User Register")
    }
    
    @IBAction func registerWithEmailUserResgiter(sender: AnyObject) {
        print("Tapped button Email User Register")
    }
    
    @IBAction func registerWithTwitterUserRegister(sender: AnyObject) {
        print("Tapped button Twitter User Register")
    }
    
    @IBAction func registerWithFacebookUserRetister(sender: AnyObject) {
        print("Tapped button Facebook User Register")
    }
    
    @IBAction func registerWithGooglePlusUserRegister(sender: AnyObject) {
        print("Tapped button Google Plus User Register")
    }
    
    @IBAction func btnPrivacePolicyUserRegister(sender: AnyObject) {
        print("Tapped button Private Policy User Register")
    }
}

extension UserRegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(false)
        return true
    }
}


