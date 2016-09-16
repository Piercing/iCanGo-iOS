
import UIKit

protocol MyProfileCellDelegate {
    func didSelectCellButtomTapped(cell: MyProfileCell)
}

class MyProfileCell: UICollectionViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var imageServiceMyProfileCell: UIImageView!
    @IBOutlet weak var imageUserMyProfileCell: UIImageView!
    @IBOutlet weak var labelPriceMyProfileCell: UILabel!
    @IBOutlet weak var labelDescriptionMyProfileCell: UILabel!
    
    var delegate: MyProfileCellDelegate!
    
    
    var service: Service? {
        didSet {
            if let service = service {
                
                labelPriceMyProfileCell.text = service.price.asLocaleCurrency
                labelDescriptionMyProfileCell.text = service.description
                
                // Load default images.
                imageServiceMyProfileCell.image = UIImage.init(named: logoService)
                imageUserMyProfileCell.image = UIImage.init(named: logoUser)
                
                // load the image asynchronous
                if service.mainImage != nil {
                    loadImage(service.mainImage!, imageView: imageServiceMyProfileCell, withAnimation: true)
                }
                
                if service.ownerImage != nil {
                    loadImage(service.ownerImage!, imageView: imageUserMyProfileCell, withAnimation: true)
                }
                
            }
        }
    }
    
    @IBAction func myProfileCell(sender: AnyObject) {
        delegate.didSelectCellButtomTapped(self)
    }
}












