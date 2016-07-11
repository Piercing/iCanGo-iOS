

import SystemConfiguration
import UIKit

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
    return User(id: "", email: "", firstName: "", lastName: "", photoURL: NSURL(), searchPreferences: "", status: "")
}


func loadImage(imageUrl: String, imageView: UIImageView) {
    
    guard let url = NSURL(string: imageUrl) else {
        return
    }
    
    let request = NSMutableURLRequest(URL: url)
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(request) { data, response, error in
        
        guard data != nil else {
            return
        }
        
        let image = UIImage(data: data!)
        
        dispatch_async(dispatch_get_main_queue(), {
            
            imageView.image = image
            imageView.fadeOut(duration: 0.0)
            imageView.fadeIn()
            
        })
    }
    
    task.resume()
    
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

func showAlert(message: String, controller: UIViewController) {
    let alertController = UIAlertController(title: "iCanGo", message: message, preferredStyle: .Alert)
    
    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
    alertController.addAction(defaultAction)
    
    controller.presentViewController(alertController, animated: true, completion: nil)
}

// Load the page view controller responsible for loading each view controller to show title and image
func showModal(callerController: UIViewController, calledContainer: UIViewController) {
    
    callerController.presentViewController(calledContainer, animated: true, completion: nil)
    
}

func checkConection(controller: UIViewController) {
    if (!isConnectedToNetwork()) {
        showAlert("No internet conection", controller: controller)
        return
    }
}

public extension UIImageView {
    
    func fadeIn(duration duration: NSTimeInterval = 1.0) {
        UIImageView.animateWithDuration(duration, animations: {
            self.alpha = 1.0
        })
    }
    
    func fadeOut(duration duration: NSTimeInterval = 1.0) {
        UIImageView.animateWithDuration(duration, animations: {
            self.alpha = 0.0
        })
    }
    
}
