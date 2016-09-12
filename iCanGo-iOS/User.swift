//
//  User.swift
//  iCanGo-iOS
//
//  Created by Alberto on 23/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

enum JSONKeysUser: String {
    case id = "id"
    case email = "email"
    case firstName = "firstName"
    case lastName = "lastName"
    case photoURL = "photoURL"
    case searchPreferences = "searchPreferences"
    case status = "status"
    case deleted = "deleted"
    case numPublishedServices = "numPublishedServices"
    case numAttendedServices = "numAttendedServices"
}

enum StatusUser: UInt {
    case active = 0
    case notActive = 1
}

struct User {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    let photoURL: NSURL?
    let searchPreferences: String?
    let status: UInt?
    let deleted: Bool
    let numPublishedServices: UInt
    let numAttendedServices: UInt
}

extension User: JSONDecodable {
    
    // MARK: - Init
    init?(dictionary: JSONDictionary) {
        
        guard let id = dictionary[JSONKeysUser.id.rawValue] as? String,
               email = dictionary[JSONKeysUser.email.rawValue] as? String,
           firstName = dictionary[JSONKeysUser.firstName.rawValue] as? String,
            lastName = dictionary[JSONKeysUser.lastName.rawValue] as? String,
              status = dictionary[JSONKeysUser.status.rawValue] as? UInt,
             deleted = dictionary[JSONKeysUser.deleted.rawValue] as? Bool,
        numPublishedServices = dictionary[JSONKeysUser.numPublishedServices.rawValue] as? UInt,
         numAttendedServices = dictionary[JSONKeysUser.numAttendedServices.rawValue] as? UInt else {
      
            return nil
        }
        
        if let imageURLString = dictionary[JSONKeysUser.photoURL.rawValue] as? String,
                     imageURL = NSURL(string: imageURLString) {
            self.photoURL = imageURL
        } else {
            self.photoURL = nil
        }

        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.status = status
        self.deleted = deleted
        self.numPublishedServices = numPublishedServices
        self.numAttendedServices = numAttendedServices
        self.searchPreferences = dictionary[JSONKeysUser.searchPreferences.rawValue] as? String
    }
}

func < (lhs: User, rhs: User) -> Bool {
    return lhs.lastName.localizedStandardCompare(rhs.lastName) == .OrderedAscending
}

class UserPersisted: NSObject, NSCoding {
    
    var id: String?
    var email: String?
    var firstName: String?
    var lastName: String?
    var photoURL: NSURL?
    var searchPreferences: String?
    var status: UInt?
    var deleted: Bool?
    var numPublishedServices: UInt?
    var numAttendedServices: UInt?

    init(id: String,
        email: String,
        firstName: String,
        lastName: String,
        photoURL: NSURL?,
        searchPreferences: String?,
        status: UInt?,
        deleted: Bool,
        numPublishedServices: UInt,
        numAttendedServices: UInt) {
        
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.photoURL = photoURL
        self.searchPreferences = searchPreferences
        self.status = status
        self.deleted = deleted
        self.numPublishedServices = numPublishedServices
        self.numAttendedServices = numAttendedServices
    }
    
    required init(coder aDecoder: NSCoder) {

        if let id = aDecoder.decodeObjectForKey(JSONKeysUser.id.rawValue) as? String {
            self.id = id
        }
        if let email = aDecoder.decodeObjectForKey(JSONKeysUser.email.rawValue) as? String {
            self.email = email
        }
        if let firstName = aDecoder.decodeObjectForKey(JSONKeysUser.firstName.rawValue) as? String {
            self.firstName = firstName
        }
        if let lastName = aDecoder.decodeObjectForKey(JSONKeysUser.lastName.rawValue) as? String {
            self.lastName = lastName
        }
        if let photoURL = aDecoder.decodeObjectForKey(JSONKeysUser.photoURL.rawValue) as? NSURL {
            self.photoURL = photoURL
        }
        if let searchPreferences = aDecoder.decodeObjectForKey(JSONKeysUser.searchPreferences.rawValue) as? String {
            self.searchPreferences = searchPreferences
        }
        if let status = aDecoder.decodeObjectForKey(JSONKeysUser.status.rawValue) as? UInt {
            self.status = status
        }
        if let deleted = aDecoder.decodeObjectForKey(JSONKeysUser.deleted.rawValue) as? Bool {
            self.deleted = deleted
        }
        if let numPublishedServices = aDecoder.decodeObjectForKey(JSONKeysUser.numPublishedServices.rawValue) as? UInt {
            self.numPublishedServices = numPublishedServices
        }
        if let numAttendedServices = aDecoder.decodeObjectForKey(JSONKeysUser.numAttendedServices.rawValue) as? UInt {
            self.numAttendedServices = numAttendedServices
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {

        if let id = self.id {
            aCoder.encodeObject(id, forKey: JSONKeysUser.id.rawValue)
        }
        if let email = self.email {
            aCoder.encodeObject(email, forKey: JSONKeysUser.email.rawValue)
        }
        if let firstName = self.firstName {
            aCoder.encodeObject(firstName, forKey: JSONKeysUser.firstName.rawValue)
        }
        if let lastName = self.lastName {
            aCoder.encodeObject(lastName, forKey: JSONKeysUser.lastName.rawValue)
        }
        if let photoURL = self.photoURL {
            aCoder.encodeObject(photoURL, forKey: JSONKeysUser.photoURL.rawValue)
        }
        if let searchPreferences = self.searchPreferences {
            aCoder.encodeObject(searchPreferences, forKey: JSONKeysUser.searchPreferences.rawValue)
        }
        if let status = self.status {
            aCoder.encodeObject(status, forKey: JSONKeysUser.status.rawValue)
        }
        if let deleted = self.deleted {
            aCoder.encodeObject(deleted, forKey: JSONKeysUser.deleted.rawValue)
        }
        if let numPublishedServices = self.numPublishedServices {
            aCoder.encodeObject(numPublishedServices, forKey: JSONKeysUser.numPublishedServices.rawValue)
        }
        if let numAttendedServices = self.numAttendedServices {
            aCoder.encodeObject(numAttendedServices, forKey: JSONKeysUser.numAttendedServices.rawValue)
        }
    }
}

func copyUser(user: User) -> UserPersisted {
    return UserPersisted(id: user.id,
                      email: user.email,
                  firstName: user.firstName,
                   lastName: user.lastName,
                   photoURL: user.photoURL,
          searchPreferences: user.searchPreferences,
                     status: user.status,
                    deleted: user.deleted,
       numPublishedServices: user.numPublishedServices,
        numAttendedServices: user.numAttendedServices)
}

func copyUser(user: UserPersisted) -> User {
             return User(id: user.id!,
                      email: user.email!,
                  firstName: user.firstName!,
                   lastName: user.lastName!,
                   photoURL: user.photoURL,
          searchPreferences: user.searchPreferences,
                     status: user.status,
                    deleted: user.deleted!,
       numPublishedServices: user.numPublishedServices!,
        numAttendedServices: user.numAttendedServices!)
}



