//
//  RoundedCornersView.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 7/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCorners: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
}
