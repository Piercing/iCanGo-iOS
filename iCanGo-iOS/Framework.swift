//
//  Framework.swift
//  iCanGo-iOS
//
//  Created by Alberto on 7/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

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



