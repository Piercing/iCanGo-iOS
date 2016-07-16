
import UIKit

protocol MyProfileCellDelegate {
    func didSelectCellButtomTapped(cell: MyProfileCell)
}

class MyProfileCell: UICollectionViewCell {
    
    // MARK: - Properties
    var delegate: MyProfileCellDelegate!
    
    @IBOutlet weak var imageServiceMyProfileCell: UIImageView!
    @IBOutlet weak var imageUserMyProfileCell: UIImageView!
    @IBOutlet weak var labelPriceMyProfileCell: UILabel!
    @IBOutlet weak var labelDescriptionMyProfileCell: UILabel!
    
    var myProfile: Service? {
        didSet {
            if let myProfile = myProfile {
                //imageServiceMyProfileCell.image = myProfile.image
                labelPriceMyProfileCell.text = String.priceToString(myProfile.price)
                labelDescriptionMyProfileCell.text = myProfile.description
            }
        }
    }
    
    var myProfilePhotoUser: Service? {
        
        didSet {
            if myProfilePhotoUser != nil {
                //imageUserMyProfileCell.image = myProfilePhotoUser.image
            }
        }
    }
    
    
    // MARK: - Mask Rounded Images
    
    
    // MARK: - Actions
    
    @IBAction func btnFavouritesMyProfileCell(sender: AnyObject) {
        print("Tapped buttom favourites My profile")
    }
    
    @IBAction func myProfileCell(sender: AnyObject) {
        delegate.didSelectCellButtomTapped(self)
        print("Tapped My profile cell")
    }
}

extension UIImage {
    
    func circularImage(size size: CGSize?) -> UIImage {
        let newSize = size ?? self.size
        
        let minEdge = min(newSize.height, newSize.width)
        let size = CGSize(width: minEdge, height: minEdge)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        
        self.drawInRect(CGRect(origin: CGPoint.zero, size: size), blendMode: .Copy, alpha: 1.0)
        
        CGContextSetBlendMode(context, .Copy)
        CGContextSetFillColorWithColor(context, UIColor.clearColor().CGColor)
        
        let rectPath = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: size))
        let circlePath = UIBezierPath(ovalInRect: CGRect(origin: CGPoint.zero, size: size))
        rectPath.appendPath(circlePath)
        rectPath.usesEvenOddFillRule = true
        rectPath.fill()
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result
    }
    
}










