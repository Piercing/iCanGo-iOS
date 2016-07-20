//
//  RoundedCornersImages.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 19/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

@IBDesignable class RoundedCornersImages: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
}

