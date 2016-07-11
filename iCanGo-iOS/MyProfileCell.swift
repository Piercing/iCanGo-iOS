
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
                labelPriceMyProfileCell.text = String.priceToString(myProfile.price!)
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
    // MARK: - Actions
    
    @IBAction func btnFavouritesMyProfileCell(sender: AnyObject) {
        print("Tapped buttom favourites My profile")
    }
    
    @IBAction func myProfileCell(sender: AnyObject) {
        delegate.didSelectCellButtomTapped(self)
        print("Tapped My profile cell")
    }
    
}
