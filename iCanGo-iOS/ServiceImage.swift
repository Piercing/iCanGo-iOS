//
//  ServiceImage.swift
//  iCanGo-iOS
//
//  Created by Alberto on 11/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

enum JSONKeysServiceImage: String {
    case id = "id"
    case imageUrl = "imageUrl"
}

struct ServiceImage {
    let id: String
    let imageUrl: NSURL
}

extension ServiceImage: JSONDecodable {
    
    // MARK: - Init
    init?(dictionary: JSONDictionary) {
        
        guard let id = dictionary[JSONKeysServiceImage.id.rawValue] as? String else {
            return nil
        }

        guard let imageUrlString = dictionary[JSONKeysServiceImage.imageUrl.rawValue] as? String,
                        imageUrl = NSURL(string: imageUrlString) else {
            return nil
        }
        
        self.id = id
        self.imageUrl = imageUrl
    }
}




