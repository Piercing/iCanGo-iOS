//
//  APIRequest.swift
//  iCanGo-iOS
//
//  Created by Alberto on 6/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

enum APIRequest {
    case GetServices(key: String, query: String)
}

extension APIRequest: Resource {
    
    var method: Method {
        switch self {
            case APIRequest.GetServices:
                return Method.GET
        }
    }
    
    var path: String {
        switch self {
            case let APIRequest.GetServices(_, query):
                return "v2/\(query)"
        }
    }
    
    var parameters: [String: String] {
        switch self {
            case let APIRequest.GetServices(_, query):
                return [
                    "query": query
                ]
        }
    }
}