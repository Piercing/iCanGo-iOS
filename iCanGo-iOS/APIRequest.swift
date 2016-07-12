//
//  APIRequest.swift
//  iCanGo-iOS
//
//  Created by Alberto on 6/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

enum APIRequest {
    case getServices(key: String, page: UInt, rows: UInt)
    case getServicesByStatus(key: String, status: String, page: UInt, rows: UInt)
    case getServiceById(key: String, id: String)
    case getServiceImages(key: String, id: String)
    case getUsers(key: String, page: UInt)
    case getUserServices(key: String, id: String, page: UInt)
    case getUserServicesByType(key: String, id: String, type: String, page: UInt)
    case getUserById(key: String, id: String)
    case getImages(key: String)
    case getImagesById(key: String, id: String)
    case postLogin(user: String, password: String)
    case postUser(user: String, password: String, firstName: String, lastName: String, photoUrl: String, searchPreferences: String, status: String)
    case postService(name: String, description: String, price: Double, tags: [String]?, idUserRequest: String, latitude: Double?, longitude: Double?, address: String?, status: Int?)
    case postServiceImage(id: String, imageUrl: NSURL)
}

extension APIRequest: Resource {
    
    var method: Method {
        switch self {
        case APIRequest.getServices,
             APIRequest.getServicesByStatus,
             APIRequest.getServiceById,
             APIRequest.getServiceImages,
             APIRequest.getUsers,
             APIRequest.getUserServices,
             APIRequest.getUserServicesByType,
             APIRequest.getUserById,
             APIRequest.getImages,
             APIRequest.getImagesById:
            return Method.GET
        case APIRequest.postLogin,
             APIRequest.postUser,
             APIRequest.postService,
             APIRequest.postServiceImage:
            return Method.POST
        }
    }
    
    var path: String {
        switch self {
        case APIRequest.getServices:
            return "services"
        case APIRequest.getServicesByStatus:
            return "services"
        case let APIRequest.getServiceById(_, id):
            return "services/\(id)"
        case let APIRequest.getServiceImages(_, id):
            return "services/\(id)/images"
        case APIRequest.getUsers:
            return "users/"
        case let APIRequest.getUserServices(_, id, _):
            return "users/\(id)/services/"
        case let APIRequest.getUserServicesByType(_, id, _, _):
            return "users/\(id)/services"
        case let APIRequest.getUserById(_, id):
            return "users/\(id)"
        case APIRequest.getImages:
            return "images"
        case let APIRequest.getImagesById(_, id):
            return "images/\(id)"
        case APIRequest.postLogin:
            return "login"
        case APIRequest.postUser:
            return "users/"
        case APIRequest.postService:
            return "services/"
        case APIRequest.postServiceImage:
            return "images/"
        }
    }

    var parameters: [String: String] {
        switch self {
        case let APIRequest.getServices(_, page, rows):
            return ["rows": String(rows), "page": String(page)]
            
        case let APIRequest.getServicesByStatus(_, status, page, rows):
            return ["status":status, "page": String(page), "rows": String(rows)]
        
        case APIRequest.getServiceById:
            return [:]

        case APIRequest.getServiceImages:
            return [:]

        case APIRequest.getUsers:
            return [:]
        
        case APIRequest.getUserServices:
            return [:]
        
        case let APIRequest.getUserServicesByType(_, _, type, _):
            return ["type":type]
        
        case APIRequest.getUserById:
            return [:]
        
        case APIRequest.getImages:
            return [:]

        case APIRequest.getImagesById:
            return [:]
            
        case let APIRequest.postLogin(user: user, password: password):
            return ["email": user, "password": password]
        
        case let APIRequest.postUser(
                    user: user,
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
            
        case let APIRequest.postService(
                   name: name,
            description: description,
                  price: price,
                   tags: tags,
          idUserRequest: idUserRequest,
               latitude: latitude,
              longitude: longitude,
                address: address,
                 status: status):
            return ["name": name,
             "description": description,
                   "price": String.priceToString(price),
                    "tags": tags != nil ? String.stringsToString(tags!) : "",
           "idUserRequest": idUserRequest,
                "latitude": latitude != nil ? String(format:"%f", latitude!) : "",
               "longitude": longitude != nil ? String(format:"%f", longitude!) : "",
                 "address": address != nil ? address! : "",
                  "status": status != nil ? String(status!) : ""]
        
        case let APIRequest.postServiceImage(id: id, imageUrl: imageUrl):
            return ["idService": id,
                    "imageUrl": imageUrl.absoluteString]
        }
    }
}
