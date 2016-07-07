//
//  Service.swift
//  iCanGo-iOS
//
//  Created by Alberto on 6/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

struct Service {
    let id: String
    let name: String
    let description: String?    // Ver si sera definitivamente opcional?
    let idUserRequest: String?    // Ver si sera definitivamente opcional?
    let idUserResponse: String?
    let dateCreated: NSDate?   // Ver si sera definitivamente opcional?
    let dateFinished: NSDate?  // Ver si sera definitivamente opcional?
    let dateDone: NSDate?
    let price: Double?
    let status: String?        // Ver si sera definitivamente opcional?
    let address: String?
    let latitude: Double?
    let longitude: Double?
    let tags: [String]?
}

extension Service: JSONDecodable {
    
    // MARK: - Init
    init?(dictionary: JSONDictionary) {
        
        guard let id = dictionary["id"] as? String,
                name = dictionary["name"] as? String else {
                return nil
        }
        
        self.id = id
        self.name = name
        self.description = dictionary["description"] as? String
        self.idUserRequest = dictionary["idUserRequest"] as? String
        self.idUserResponse = dictionary["idUserResponse"] as? String
        self.dateCreated = dictionary["dateCreated"] as? NSDate
        self.dateFinished = dictionary["dateFinished"] as? NSDate
        self.dateDone = dictionary["dateDone"] as? NSDate
        self.price = dictionary["price"] as? Double
        self.status = dictionary["status"] as? String
        self.address = dictionary["address"] as? String
        
        if let latitude = dictionary["latitude"] as? String {
            self.latitude = Double(latitude)
        } else {
            self.latitude = nil
        }
        
        if let longitude = dictionary["longitude"] as? String {
            self.longitude = Double(longitude)
        } else {
            self.longitude = nil
        }
        
        if let tags = dictionary["tags"] as? String {
            self.tags = String.stringToStrings(tags, separator: " ")
        } else {
            self.tags = nil
        }
        
        /*
        guard let id = dictionary["id"] as? Int,
                  name = dictionary["name"] as? String,
                  description = dictionary["description"] as? String,
                  idUserRequest = dictionary["idUserRequest"] as? Int,
                  dateCreatedString = dictionary["dateCreated"] as? String,
                  dateFinishedString = dictionary["dateFinished"] as? String,
                  timeFinishedString = dictionary["timeFinished"] as? String,
                  status = dictionary["status"] as? String else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.description = description
        self.idUserRequest = idUserRequest
        self.status = status
        
        // Date Created
        if let dateCreated = NSDate.dateFromStringsWithFormat(dateString: dateCreatedString,
                                                             timeString: nil,
                                                             withFormat: "yyyy/MM/dd") {
            self.dateCreated = dateCreated
        } else {
            return nil
        }

        // Date & Time Finished -> NSDate
        if let dateFinished = NSDate.dateFromStringsWithFormat(dateString: dateFinishedString,
                                                               timeString: timeFinishedString,
                                                               withFormat: "yyyy/MM/dd HH:mm") {
            self.dateFinished = dateFinished
        } else {
            return nil
        }
        
        // idUserResponse
        if let idUserResponse = dictionary["idUserResponse"] as? Int {
            self.idUserResponse = idUserResponse
        } else {
            self.idUserResponse = nil
        }
    
        // dateDone
        if let dateDone = dictionary["dateDone"] as? String,
               timeDone = dictionary["timeDone"] as? String {
            self.dateDone = NSDate.dateFromStringsWithFormat(dateString: dateDone, timeString: timeDone, withFormat: "yyyy/MM/dd HH:mm")
        } else {
            self.dateDone = nil
        }
        
        // price
        if let price = dictionary["price"] as? Double {
            self.price = price
        } else {
            self.price = nil
        }

        // latitude & longitude
        if let latitude = dictionary["latitude"] as? Double,
               longitude = dictionary["longitude"] as? Double {
            self.latitude = round(10000000 * latitude) / 10000000
            self.longitude = round(10000000 * longitude) / 10000000
        } else {
            self.latitude = nil
            self.longitude = nil
        }
        
        // address
        if let address = dictionary["address"] as? String {
            self.address = address
        } else {
            self.address = nil
        }
        
        // tags
        if let tags = dictionary["tags"] as? [String] {
            self.tags = tags
        } else {
            self.tags = nil
        }
        */
    }
}

func < (lhs: Service, rhs: Service) -> Bool {
    return lhs.name.localizedStandardCompare(rhs.name) == .OrderedAscending
    
}



