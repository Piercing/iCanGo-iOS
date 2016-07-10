//
//  User.swift
//  iCanGo-iOS
//
//  Created by Alberto on 23/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

struct User {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    let photoURL: NSURL
    let searchPreferences: String?
    let status: String?
}

extension User: JSONDecodable {
    
    // MARK: - Init
    init?(dictionary: JSONDictionary) {
        
        guard let email = dictionary["email"] as? String,
              firstName = dictionary["firstName"] as? String,
               lastName = dictionary["lastName"] as? String else {
            return nil
        }

        guard let imageURLString = dictionary["photoUrl"] as? String,
                        imageURL = NSURL(string: imageURLString) else {
            return nil
        }

        self.id = dictionary["id"] as! String
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.photoURL = imageURL
        self.searchPreferences = dictionary["searchPreferences"] as? String
        self.status = dictionary["status"] as? String
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
    var status: String?
    
    init(id: String?, email: String?, firstName: String?, lastName: String?, photoURL: NSURL?, searchPreferences: String?, status: String?) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.photoURL = photoURL
        self.searchPreferences = searchPreferences
        self.status = status
    }
    
    required init(coder aDecoder: NSCoder) {
        if let id = aDecoder.decodeObjectForKey("id") as? String {
            self.id = id
        }
        if let email = aDecoder.decodeObjectForKey("email") as? String {
            self.email = email
        }
        if let firstName = aDecoder.decodeObjectForKey("firstName") as? String {
            self.firstName = firstName
        }
        if let lastName = aDecoder.decodeObjectForKey("lastName") as? String {
            self.lastName = lastName
        }
        if let photoURL = aDecoder.decodeObjectForKey("photoURL") as? NSURL {
            self.photoURL = photoURL
        }
        if let searchPreferences = aDecoder.decodeObjectForKey("searchPreferences") as? String {
            self.searchPreferences = searchPreferences
        }
        if let status = aDecoder.decodeObjectForKey("status") as? String {
            self.status = status
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let id = self.id {
            aCoder.encodeObject(id, forKey: "id")
        }
        if let email = self.email {
            aCoder.encodeObject(email, forKey: "email")
        }
        if let firstName = self.firstName {
            aCoder.encodeObject(firstName, forKey: "firstName")
        }
        if let lastName = self.lastName {
            aCoder.encodeObject(lastName, forKey: "lastName")
        }
        if let photoURL = self.photoURL {
            aCoder.encodeObject(photoURL, forKey: "photoURL")
        }
        if let searchPreferences = self.searchPreferences {
            aCoder.encodeObject(searchPreferences, forKey: "searchPreferences")
        }
        if let status = self.status {
            aCoder.encodeObject(status, forKey: "status")
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
                         status: user.status)
}

func copyUser(user: UserPersisted) -> User {
    return User(id: user.id!,
                email: user.email!,
                firstName: user.firstName!,
                lastName: user.lastName!,
                photoURL: user.photoURL!,
                searchPreferences: user.searchPreferences,
                status: user.status)
}



