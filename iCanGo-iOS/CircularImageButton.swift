//
//  CircularImageButton.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 16/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

@IBDesignable class CircularImageButton: UIButton {
    
    override func setImage(image: UIImage?, forState state: UIControlState) {
        let circularImage = image?.circularImage(size: nil)
        super.setImage(circularImage, forState: state)
    }
}