//
//  Response.swift
//  iCanGo-iOS
//
//  Created by Alberto on 29/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

enum JSONKeysResponse: String {
    case totalRows = "totalRows"
    case page = "page"
    case rows = "rows"
    case error = "error"
    case data = "data"
}

struct Response {
    
    let totalRows: UInt
    let page: UInt?
    let rows: UInt?
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
        
        guard let totalRows = dictionary[JSONKeysResponse.totalRows.rawValue] as? UInt,
                      error = dictionary[JSONKeysResponse.error.rawValue] as? String else {
            return nil
        }
        
        if let pageString = dictionary[JSONKeysResponse.page.rawValue] as? String,
                     page = UInt(pageString) {
            self.page = page
        } else {
            self.page = nil
        }
        
        if let rowsString = dictionary[JSONKeysResponse.rows.rawValue] as? String,
                     rows = UInt(rowsString) {
            self.rows = rows
        } else {
            self.rows = nil
        }
        
        self.totalRows = totalRows
        self.error = error
        self.data = dictionary[JSONKeysResponse.data.rawValue]
    }
}

