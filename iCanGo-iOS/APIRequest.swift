//
//  APIRequest.swift
//  iCanGo-iOS
//
//  Created by Alberto on 6/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

enum APIRequest {
    case GetServices(key: String, query: String, page: UInt)
    case GetService(key: String, query: String)
    case GetUsers(key: String, query: String, page: UInt)
    case GetUser(key: String, query: String)
    case PostLogin(user: String, password: String)
    case PostUser(user: String, password: String, firstName: String, lastName: String, photoUrl: String, searchPreferences: String, status: String)
    case PostService(name: String, price: Double, tags: [String], idUserRequest: String, latitude: Double, longitude: Double, status: String)
}

extension APIRequest: Resource {
    
    var method: Method {
        switch self {
            case APIRequest.GetServices,
                 APIRequest.GetService,
                 APIRequest.GetUsers,
                 APIRequest.GetUser:
                 return Method.GET
            case APIRequest.PostLogin,
                 APIRequest.PostUser,
                 APIRequest.PostService:
                 return Method.POST
        }
    }
    
    var path: String {
        switch self {
            case APIRequest.GetServices:
                return "services/"
            case let APIRequest.GetService(_, query):
                return "services/\(query)"
            case APIRequest.GetUsers:
                return "users/"
            case let APIRequest.GetUser(_, query):
                return "users/\(query)"
            case APIRequest.PostLogin:
                return "login"
            case APIRequest.PostUser:
                return "users/"
            case APIRequest.PostService:
                return "services/"
        }
    }
    
    var parameters: [String: String] {
        switch self {
            case APIRequest.GetServices:
                return [:]
            
            case APIRequest.GetService:
                return [:]
            
            case APIRequest.GetUsers:
                return [:]
            
            case APIRequest.GetUser:
                return [:]
            
            case let APIRequest.PostLogin(user: user, password: password):
                return ["email": user, "password": password]
            
            case let APIRequest.PostUser(user: user,
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
            
            case let APIRequest.PostService(name: name,
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