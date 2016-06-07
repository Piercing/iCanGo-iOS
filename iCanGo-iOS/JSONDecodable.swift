//
//  JSONDecodable.swift
//  iCanGo-iOS
//
//  Created by Alberto on 6/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

protocol JSONDecodable
{
    init?(dictionary: JSONDictionary)
}

// MARK: Methods
func decode<T: JSONDecodable>(data: NSData) -> [T]? {

    guard let JSONObject = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
              JSONDictionaries = JSONObject as? [JSONDictionary] else {
        return nil
    }
    
    return JSONDictionaries.flatMap { T(dictionary: $0) }
}





