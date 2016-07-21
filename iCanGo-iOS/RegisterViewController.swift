

import UIKit

class RegisterViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var firstNameRegister: UITextField!
    @IBOutlet weak var secondNameResgister: UITextField!
    @IBOutlet weak var emailRegister: UITextField!
    @IBOutlet weak var userRegister: UITextField!
    @IBOutlet weak var passRegister: UITextField!
    @IBOutlet weak var repeatPassRegister: UITextField!
    @IBOutlet weak var cityRegister: UITextField!
    @IBOutlet weak var countryRegister: UITextField!
    @IBOutlet weak var imageUserRegister: UIImageView!
    
    let titleView = "Register"
    
    // MARK: - Init
    
    convenience init() {
        self.init(nibName: "RegisterView", bundle: nil)
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let title = Appearance.setupUI(self.view, title: self.titleView)
        self.title = title
    }
    
    // MARK: - Actions
    
    @IBAction func saveRegister(sender: AnyObject) {
        // TODO:
        print("Tapped buttom register")
    }
    @IBAction func cancelRegister(sender: AnyObject) {
        print("Tapped buttom cancel register")
    }
}
