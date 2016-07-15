//
//  Framework.swift
//  iCanGo-iOS
//
//  Created by Alberto on 7/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation
import UIKit

// NSDate 
extension NSDate {
    
    static func dateFromStringsWithFormat(dateString date: String, timeString time: String?, withFormat format: String) -> NSDate? {
        
        let dateTimeString: String
        
        if let time = time {
            dateTimeString =  date + " " + time
        } else {
            dateTimeString =  date
        }
        
        let dateTimeFormated = NSDateFormatter()
        dateTimeFormated.dateFormat = format
        dateTimeFormated.timeZone = NSTimeZone(abbreviation: timeZoneApp)
        
        if let date = dateTimeFormated.dateFromString(dateTimeString) {
            return date
        } else {
            return nil
        }
    }
}

// NSString
extension String {
    
    static func stringsToString(strings: [String]) -> String {
        
        return strings.reduce("", combine: { $0 == "" ? $1 : $0 + " " + $1 })
    }
    
    static func stringToStrings(string: String, separator: Character) -> [String] {
        
        return string.characters.split{$0 == separator}.map(String.init)
    }
}

// UIImage
extension UIImage {
    
    var uncompressedPNGData: NSData      { return UIImagePNGRepresentation(self)!        }
    var highestQualityJPEGNSData: NSData { return UIImageJPEGRepresentation(self, 1.0)!  }
    var highQualityJPEGNSData: NSData    { return UIImageJPEGRepresentation(self, 0.75)! }
    var mediumQualityJPEGNSData: NSData  { return UIImageJPEGRepresentation(self, 0.5)!  }
    var lowQualityJPEGNSData: NSData     { return UIImageJPEGRepresentation(self, 0.25)! }
    var lowestQualityJPEGNSData:NSData   { return UIImageJPEGRepresentation(self, 0.0)!  }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}



