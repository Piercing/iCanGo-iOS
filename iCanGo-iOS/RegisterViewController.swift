

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
    
    
    // MARK: - Init
    
    convenience init() {
        self.init(nibName: "RegisterView", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: Methods
    
    func setupUI() -> Void {
        self.title = "Register"
        Appearance.customizeAppearance(self.view)
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
