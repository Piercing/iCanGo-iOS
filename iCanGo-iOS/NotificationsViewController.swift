

import UIKit

class NotificationsViewController: UIViewController {
    
    // MARK: - Properties
    
    let titleView = "Notifications"
    
    // MARK: - Init
    
    convenience init() {
        self.init(nibName: "NotificationsView", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = Appearance.setupUI(self.view, title: self.titleView)
        self.title = title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
