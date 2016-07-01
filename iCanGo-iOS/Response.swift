//
//  Response.swift
//  iCanGo-iOS
//
//  Created by Alberto on 29/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

struct Response {
    
    let totalRows: UInt
    let error: String
    private let data: AnyObject?
    
    var result: JSONDictionary? {
        
        guard let dictionaries = data as? [JSONDictionary] else {
            return nil
        }
        
        return dictionaries[0]
    }
    
    var results: [JSONDictionary]? {
        
        guard let dictionaries = data as? [JSONDictionary] else {
            return nil
        }
        
        return dictionaries
    }
}

extension Response: JSONDecodable {
    
    init?(dictionary: JSONDictionary) {
        
        guard let totalRows = dictionary["totalRows"] as? UInt,
                      error = dictionary["error"] as? String else {
            return nil
        }
        
        self.totalRows = totalRows
        self.error = error
        self.data = dictionary["data"]
    }
}

