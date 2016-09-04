//
//  Service.swift
//  iCanGo-iOS
//
//  Created by Alberto on 6/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

enum JSONKeysService: String {
    case id = "id"
    case name = "name"
    case description = "description"
    case dateCreated = "dateCreated"
    case dateFinished = "dateFinished"
    case dateDone = "dateDone"
    case price = "price"
    case tags = "tags"
    case idUserRequest = "idUserRequest"
    case idUserResponse = "idUserResponse"
    case latitude = "latitude"
    case longitude = "longitude"
    case status = "status"
    case deleted = "deleted"
    case mainImage = "mainImage"
    case address = "address"
    case ownerImage = "ownerImage"
    case images = "images"
    case imageUrl = "imageUrl"
    case userFirstName = "userFirstName"
    case userLastName = "userLastName"
    case numPublishedServices = "numPublishedServices"
    case numAttendedServices = "numAttendedServices"
}

enum StatusService: UInt {
    case pending = 0
    case requestedToAttend = 1
    case acceptedToAttend = 2
    case inProgress = 3
    case finished = 4
    case confirmed = 5
    case cancelled = 6    
}

struct Service {
    let id: String
    let name: String
    let description: String
    let dateCreated: NSDate
    let dateFinished: NSDate?
    let dateDone: NSDate?
    let price: Double
    let tags: [String]?
    let idUserRequest: String
    let idUserResponse: String?
    let latitude: Double?
    let longitude: Double?
    let status: UInt?
    let deleted: Bool
    let mainImage: NSURL?
    let address: String?
    let ownerImage: NSURL?
    let images: [ServiceImage]?
    let userFirstName: String
    let userLastName: String
    let numPublishedServices: UInt
    let numAttendedServices: UInt
}

extension Service: JSONDecodable {
    
    // MARK: - Init
    init?(dictionary: JSONDictionary) {
        
        guard let id = dictionary[JSONKeysService.id.rawValue] as? String,
                name = dictionary[JSONKeysService.name.rawValue] as? String,
         description = dictionary[JSONKeysService.description.rawValue] as? String,
   dateCreatedString = dictionary[JSONKeysService.dateCreated.rawValue] as? String,
               price = dictionary[JSONKeysService.price.rawValue] as? Double,
       idUserRequest = dictionary[JSONKeysService.idUserRequest.rawValue] as? String,
              status = dictionary[JSONKeysService.status.rawValue] as? UInt,
             deleted = dictionary[JSONKeysService.deleted.rawValue] as? Bool,
       userFirstName = dictionary[JSONKeysService.userFirstName.rawValue] as? String,
        userLastName = dictionary[JSONKeysService.userLastName.rawValue] as? String,
        numPublishedServices = dictionary[JSONKeysService.numPublishedServices.rawValue] as? UInt,
         numAttendedServices = dictionary[JSONKeysService.numAttendedServices.rawValue] as? UInt else {
            
            return nil
        }

        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.idUserRequest = idUserRequest
        self.status = status
        self.deleted = deleted
        self.userFirstName = userFirstName
        self.userLastName = userLastName
        self.numPublishedServices = numPublishedServices
        self.numAttendedServices = numAttendedServices
        
        if let dateCreated = NSDate.dateFromStringsWithFormat(dateString: dateCreatedString,
                                                              timeString: nil, withFormat: "dd-MM-yyyy") {
            self.dateCreated = dateCreated
        } else {
            return nil
        }
        
        if let dateFinishedString = dictionary[JSONKeysService.dateFinished.rawValue] as? String,
                     dateFinished = NSDate.dateFromStringsWithFormat(dateString: dateFinishedString,
                                                                     timeString: nil, withFormat: "dd-MM-yyyy") {
            self.dateFinished = dateFinished
        } else {
            self.dateFinished = nil
        }
        
        if let dateDoneString = dictionary[JSONKeysService.dateDone.rawValue] as? String,
                     dateDone = NSDate.dateFromStringsWithFormat(dateString: dateDoneString,
                                                                 timeString: nil, withFormat: "dd-MM-yyyy") {
            self.dateDone = dateDone
        } else {
            self.dateDone = nil
        }
        
        if let tags = dictionary[JSONKeysService.tags.rawValue] as? String {
            self.tags = String.stringToStrings(tags, separator: " ")
        } else {
            self.tags = nil
        }
        
        if let idUserResponse = dictionary[JSONKeysService.idUserResponse.rawValue] as? String {
            self.idUserResponse = idUserResponse
        } else {
            self.idUserResponse = nil
        }

        if let latitude = dictionary[JSONKeysService.latitude.rawValue] as? Double {
            self.latitude = Double(latitude)
        } else {
            self.latitude = nil
        }

        if let longitude = dictionary[JSONKeysService.longitude.rawValue] as? Double {
            self.longitude = Double(longitude)
        } else {
            self.longitude = nil
        }
        
        if let mainImageString = dictionary[JSONKeysService.mainImage.rawValue] as? String,
                     mainImage = NSURL(string: mainImageString) {
            self.mainImage = mainImage
        } else {
            self.mainImage = nil
        }
        
        if let address = dictionary[JSONKeysService.address.rawValue] as? String {
            self.address = address
        } else {
            self.address = nil
        }

        if let ownerImageString = dictionary[JSONKeysService.ownerImage.rawValue] as? String,
                     ownerImage = NSURL(string: ownerImageString) {
            self.ownerImage = ownerImage
        } else {
            self.ownerImage = nil
        }
        
        if let imagesDictionaries = dictionary[JSONKeysService.images.rawValue] as? [JSONDictionary] {
            
            self.images = [ServiceImage]()
            
            for imageDictionary in imagesDictionaries {
            
                let idImageService = imageDictionary[JSONKeysService.id.rawValue] as? String
    
                if let imageUrlServiceString = imageDictionary[JSONKeysService.imageUrl.rawValue] as? String,
                             imageUrlService = NSURL(string: imageUrlServiceString) {
                
                    let serviceImage = ServiceImage(id: idImageService!, imageUrl: imageUrlService)
                    self.images?.append(serviceImage)
                }
            }
            
        } else {
            self.images = nil
        }
    }
    
    var proxyForComparison: String {
        get {
            return id
        }
    }
}


func < (lhs: Service, rhs: Service) -> Bool {
    return lhs.name.localizedStandardCompare(rhs.name) == .OrderedAscending
}


func ==(lhs: Service, rhs: Service) -> Bool {
    
    guard (lhs.dynamicType == rhs.dynamicType) else {
        return false
    }
    
    return (lhs.proxyForComparison == rhs.proxyForComparison)
}


extension Service: Hashable {
    
    var hashValue: Int {
        get {
            return id.hashValue
        }
    }
}



