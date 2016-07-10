
import UIKit

// Delegate for cell
protocol ServiceCellDelegate {
    func didSelectCellButtomTapped(cell: ServiceCell )
}

class ServiceCell: UICollectionViewCell {
    
    var delegate: ServiceCellDelegate!
    
    @IBOutlet weak var imageService: UIImageView!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var service: Service? {
        didSet {
            if let service = service {
                //imageService.image = service.image
                //imageUser.image = service.image
                priceLabel.text = String.priceToString(service.price!)
                commentLabel.text = service.description
            }
        }
    }
    
    var user: User? {
        didSet {
            if user != nil {
                //imageUser.image = user.image
            }
        }
    }
    @IBAction func btnServiceCell(sender: AnyObject) {
        
        delegate.didSelectCellButtomTapped(self)
        print("Tap service cell")
        
    }
}
