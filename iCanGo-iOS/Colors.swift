//
//  Colors.swift
//  iCanGo-iOS
//
//  Created by Alberto on 17/8/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

extension UIColor {
    
    enum Name {
        case BorderTextFieldNormal
        
        var rgbaValue: UInt32! {
            switch self {
            case .BorderTextFieldNormal:
                return 0xcdcdcdff
            }
        }
    }
    
    convenience init(named name: Name) {
        self.init(rgbaValue: name.rgbaValue)
    }

    convenience init(rgbaValue: UInt32) {
        
        let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
        let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
        let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
        let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

