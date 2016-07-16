//
//  CircularImageView.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 16/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

@IBDesignable class CircularImageView: UIImageView {
    
    override var image: UIImage? {
        didSet {
            super.image = image?.circularImage(size: nil)
        }
    }
}
