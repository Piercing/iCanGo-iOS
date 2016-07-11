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
func decode<T: JSONDecodable>(data: NSData) -> T? {
    
    guard let JSONObject = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
          JSONDictionary = JSONObject as? JSONDictionary else {
        return nil
    }
    
    return T(dictionary: JSONDictionary)
}

func decode<T: JSONDecodable>(dictionary: [JSONDictionary]) -> [T]? {
    
    return dictionary.flatMap { T(dictionary: $0) }
}

func decode<T: JSONDecodable>(dictionary: JSONDictionary) -> T? {
    
    return T(dictionary: dictionary)
}


