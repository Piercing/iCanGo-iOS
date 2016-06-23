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
    case GetUsers(key: String, query: String)
}

extension APIRequest: Resource {
    
    var method: Method {
        switch self {
            case APIRequest.GetServices,
                 APIRequest.GetUsers:
                return Method.GET
        }
    }
    
    var path: String {
        switch self {
            case let APIRequest.GetServices(_, query):
                return "v2/\(query)"
            case let APIRequest.GetUsers(_, query):
                return "users/\(query)"
        }
    }
    
    var parameters: [String: String] {
        switch self {
            case let APIRequest.GetServices(_, query):
                return [
                    "query": query
                ]
            case let APIRequest.GetUsers(_, query):
                return [
                    "query": query
            ]
        }
    }
}