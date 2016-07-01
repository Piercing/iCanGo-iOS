//
//  APIRequest.swift
//  iCanGo-iOS
//
//  Created by Alberto on 6/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

enum APIRequest {
    case getServices(key: String, query: String, page: UInt)
    case getService(key: String, query: String)
    case getUsers(key: String, query: String, page: UInt)
    case getUser(key: String, query: String)
    case postLogin(user: String, password: String)
    case postUser(user: String, password: String, firstName: String, lastName: String, photoUrl: String, searchPreferences: String, status: String)
    case postService(name: String, price: Double, tags: [String], idUserRequest: String, latitude: Double, longitude: Double, status: String)
}

extension APIRequest: Resource {
    
    var method: Method {
        switch self {
            case APIRequest.getServices,
                 APIRequest.getService,
                 APIRequest.getUsers,
                 APIRequest.getUser:
                 return Method.GET
            case APIRequest.postLogin,
                 APIRequest.postUser,
                 APIRequest.postService:
                 return Method.POST
        }
    }
    
    var path: String {
        switch self {
            case APIRequest.getServices:
                return "services/"
            case let APIRequest.getService(_, query):
                return "services/\(query)"
            case APIRequest.getUsers:
                return "users/"
            case let APIRequest.getUser(_, query):
                return "users/\(query)"
            case APIRequest.postLogin:
                return "login"
            case APIRequest.postUser:
                return "users/"
            case APIRequest.postService:
                return "services/"
        }
    }
    
    var parameters: [String: String] {
        switch self {
            case APIRequest.getServices:
                return [:]
            
            case APIRequest.getService:
                return [:]
            
            case APIRequest.getUsers:
                return [:]
            
            case APIRequest.getUser:
                return [:]
            
            case let APIRequest.postLogin(user: user, password: password):
                return ["email": user, "password": password]
            
            case let APIRequest.postUser(user: user,
                                     password: password,
                                    firstName: firstName,
                                     lastName: lastName,
                                     photoUrl: photoUrl,
                            searchPreferences: searchPreferences,
                                       status: status):
                return ["email": user,
                        "password": password,
                        "firstName": firstName,
                        "lastName": lastName,
                        "photoUrl": photoUrl,
                        "searchPreferences": searchPreferences,
                        "status": status]
            
            case let APIRequest.postService(name: name,
                                           price: price,
                                            tags: tags,
                                   idUserRequest: idUserRequest,
                                        latitude: latitude,
                                       longitude: longitude,
                                          status: status):
                return ["name": name,
                        "price": String.priceToString(price),
                        "tags": String.stringsToString(tags),
                        "idUserRequest": idUserRequest,
                        "latitude": String(format:"%f", latitude),
                        "longitude": String(format:"%f", longitude),
                        "status": status]
        }
    }
}