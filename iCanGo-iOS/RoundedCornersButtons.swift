//
//  RoundedCornersButtons.swift
//  iCanGo-iOS
//
//  Created by MacBook Pro on 20/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

@IBDesignable class RoundedCornersButtons: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
}
