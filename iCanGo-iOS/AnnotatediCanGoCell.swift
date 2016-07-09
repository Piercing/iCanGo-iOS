//
//  AnnotatediCanGoCellCollectionViewCell.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín MacBook Pro on 7/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

// Delegate for cell
protocol  AnnotatediCanGoCellDelegate {
    func didSelectCellButtomTapped(cell: AnnotatediCanGoCell )
}

class AnnotatediCanGoCell: UICollectionViewCell {
    
    var delegate: AnnotatediCanGoCellDelegate!
    
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
