
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
    
    override func awakeFromNib() {
//        self.contentView.layer.borderWidth = 1.0
//        self.contentView.layer.borderColor = UIColor.clearColor().CGColor
//        self.contentView.layer.masksToBounds = true
//        
//        self.layer.shadowColor = UIColor.grayColor().CGColor
//        self.layer.shadowOffset = CGSizeMake(0, 0.5)
//        self.layer.shadowRadius = 0.5
//        self.layer.shadowOpacity = 1.0
//        self.layer.masksToBounds = false
//        self.layer.shadowPath = UIBezierPath(
//            roundedRect: self.bounds,
//            cornerRadius: self.contentView.layer.cornerRadius).CGPath
    }
    
    var service: Service? {
        didSet {
            if let service = service {
                priceLabel.text = service.price.asLocaleCurrency
                commentLabel.text = service.description
                
                // load the image asynchronous
                if service.mainImage != nil {
                    loadImage(service.mainImage!, imageView: imageService)
                }
                
                if service.ownerImage != nil {
                    loadImage(service.ownerImage!, imageView: imageUser)
                }
            }
        }
    }
    
    @IBAction func btnServiceCell(sender: AnyObject) {
        delegate.didSelectCellButtomTapped(self)
        print("Tap service cell")
        
    }
}
