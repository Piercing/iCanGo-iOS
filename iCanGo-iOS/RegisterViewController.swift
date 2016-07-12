

import UIKit

class RegisterViewController: UIViewController {

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
}
