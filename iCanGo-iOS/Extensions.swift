//
//  Extensions.swift
//  iCanGo-iOS
//
//  Created by Pedro Martin Gomez on 16/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

extension UIView {
    
    func fadeIn(duration duration: NSTimeInterval = 1.0) {
        UIView.animateWithDuration(duration, animations: {
            self.alpha = 1.0
        })
    }
    
    func fadeOut(duration duration: NSTimeInterval = 1.0) {
        UIView.animateWithDuration(duration, animations: {
            self.alpha = 0.0
        })
    }
    
}

extension Double {
    
    func ToString() -> String {
        return String(format:"%f", self)
    }
    
}