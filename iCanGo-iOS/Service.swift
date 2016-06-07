//
//  Service.swift
//  iCanGo-iOS
//
//  Created by Alberto on 6/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

struct Service {
    let id: Int
    let name: String
    let description: String
    let idUserRequest: Int
    let idUserResponse: Int?
    let dateCreated: NSDate
    let dateFinished: NSDate
    let dateDone: NSDate?
    let price: Double?
    let status: String
    let address: String?
    let latitude: Double?
    let longitude: Double?
    let tags: [String]?
}

extension Service: JSONDecodable {
    
    // MARK: - Init
    init?(dictionary: JSONDictionary) {
        
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
    }
}




