//
//  APIRequest.swift
//  iCanGo-iOS
//
//  Created by Alberto on 6/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

enum APIRequest {
    case getServices(key: String, query: String, page: UInt, rows: UInt)
    case getServicesByStatus(key: String, query: String, status: String, page: UInt, rows: UInt)
    case getService(key: String, query: String)
    case getServiceImages(key: String, query: String)
    case getUsers(key: String, query: String, page: UInt)
    case getUsersServices(key: String, query: String, page: UInt)
    case getUsersServicesByType(key: String, query: String, type: String, page: UInt)
    case getUser(key: String, query: String)
    case postLogin(user: String, password: String)
    case postUser(user: String, password: String, firstName: String, lastName: String, photoUrl: String, searchPreferences: String, status: String)
    case postService(name: String, price: Double, tags: [String], idUserRequest: String, latitude: Double, longitude: Double, status: String)
}

extension APIRequest: Resource {
    
    var method: Method {
        switch self {
        case APIRequest.getServices,
             APIRequest.getServicesByStatus,
             APIRequest.getService,
             APIRequest.getServiceImages,
             APIRequest.getUsers,
             APIRequest.getUsersServices,
             APIRequest.getUsersServicesByType,
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
            return "services"
        case APIRequest.getServicesByStatus:
            return "services"
        case let APIRequest.getService(_, query):
            return "services/\(query)"
        case let APIRequest.getServiceImages(_, query):
            return "services/\(query)/images"
        case APIRequest.getUsers:
            return "users/"
        case let APIRequest.getUsersServices(_, query, _):
            return "users/\(query)/services/"
        case let APIRequest.getUsersServicesByType(_, query, _, _):
            return "users/\(query)/services"
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
        case let APIRequest.getServices(_, _, page, rows):
            return ["rows": String(rows), "page": String(page)]
            
        case let APIRequest.getServicesByStatus(_, _, status, page, rows):
            return ["status":status, "page": String(page), "rows": String(rows)]
        
        case APIRequest.getService:
            return [:]

        case APIRequest.getServiceImages:
            return [:]

        case APIRequest.getUsers:
            return [:]
        
        case APIRequest.getUsersServices:
            return [:]
        
        case let APIRequest.getUsersServicesByType(_, _, type, _):
            return ["type":type]
        
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