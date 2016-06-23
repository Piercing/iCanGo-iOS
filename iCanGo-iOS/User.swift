//
//  User.swift
//  iCanGo-iOS
//
//  Created by Alberto on 23/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

struct User {
    let id: String?
    let email: String
    let firstName: String
    let lastName: String
    let photoURL: NSURL
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

        self.id = nil
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.photoURL = imageURL        
    }
}




