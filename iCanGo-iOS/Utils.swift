
import SystemConfiguration
import UIKit
import RxSwift

var totalRows: Int = 0

func actionStarted(activityIndicatorView: UIActivityIndicatorView) -> Bool {
    
    activityIndicatorView.hidden = false
    activityIndicatorView.startAnimating()
    return true
}

func actionFinished(activityIndicatorView: UIActivityIndicatorView) -> Bool {
    
    activityIndicatorView.stopAnimating()
    activityIndicatorView.hidden = true
    return false;
}

func isUserloged() -> Bool {
    
    let user = loadUserAuthInfo()
    return user.id != ""
}

func saveAuthInfo(user: User) -> Void {
    
    let userPersisted = copyUser(user)
    NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(userPersisted), forKey: "user")
}

func loadUserAuthInfo() -> User {
    
    if let data = NSUserDefaults.standardUserDefaults().objectForKey("user") as? NSData {
        let userPersisted = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? UserPersisted
        let user = copyUser(userPersisted!)
        return user
    }
    
    return User(id: "",
                email: "",
                firstName: "",
                lastName: "",
                photoURL: NSURL(),
                searchPreferences: "",
                status: 0, deleted: false,
                numPublishedServices: 0,
                numAttendedServices: 0)
}

func logoutUser() -> Void {
    NSUserDefaults.standardUserDefaults().removeObjectForKey("user")
}

func loadImage(imageUrl: NSURL, imageView: UIImageView, withAnimation: Bool) {
    
    let session = Session.iCanGoSessionImages()
    let _ = session.getImageData(imageUrl)
        
        .observeOn(MainScheduler.instance)
        .subscribe { event in
            
            switch event {
            case let .Next(data):
                let image = UIImage(data: data)
                imageView.image = image
                if withAnimation {
                    imageView.fadeOut(duration: 0.0)
                    imageView.fadeIn()
                }
                
            case .Error (let error):
                print(error)
                return
                
            default:
                break
            }
    }
}

func isConnectedToNetwork() -> Bool {
    
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
        SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
    }
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
}

func showAlert(title: String, message: String, controller: UIViewController) {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    alertController.addAction(UIAlertAction(title: ok, style: .Default, handler: nil))
    controller.presentViewController(alertController, animated: true, completion: nil)
}

func showAlertWithActions(title: String, message: String, controller: UIViewController, actions: [UIAlertAction]) {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    for action in actions {
        alertController.addAction(action)
    }
    controller.presentViewController(alertController, animated: true, completion: nil)
}

// Load the page view controller responsible for loading each view controller to show title and image
func showModal(callerController: UIViewController, calledContainer: UIViewController) {
    
    callerController.presentViewController(calledContainer, animated: true, completion: nil)
}

func checkConection(controller: UIViewController) {
    
    if (!isConnectedToNetwork()) {
        showAlert(noConnectionTitle, message: noConnectionMessage, controller: controller)
        return
    }
}


