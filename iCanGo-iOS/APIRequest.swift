//
//  APIRequest.swift
//  iCanGo-iOS
//
//  Created by Alberto on 6/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

enum APIRequest {
    case getServices(key: String, latitude: Double?, longitude: Double?, distance: UInt?, searchText: String?, page: UInt, rows: UInt)
    case getServicesByStatus(key: String, status: UInt, page: UInt, rows: UInt)
    case getServiceById(key: String, id: String)
    case getServiceImages(key: String, id: String)
    case getUsers(key: String, page: UInt)
    case getUserServices(key: String, id: String, page: UInt)
    case getUserServicesByType(key: String, id: String, type: UInt, page: UInt)
    case getUserById(key: String, id: String)
    case getImages(key: String)
    case getImagesById(key: String, id: String)
    case getImageData(key: String, urlImage: NSURL)
    case postLogin(user: String, password: String)
    case postUser(user: String, password: String, firstName: String, lastName: String, photoUrl: NSURL?, searchPreferences: String?, status: UInt?)
    case postService(name: String, description: String, price: Double, tags: String?, idUserRequest: String, latitude: Double?, longitude: Double?, address: String?, status: UInt?)
    case postServiceImage(id: String, imageUrl: NSURL)
    case putService(id: String, name: String, description: String, price: Double, tags: [String]?, idUserRequest: String, latitude: Double?, longitude: Double?, address: String?, status: UInt?)
    case deleteServiceById(key: String, id: String)
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
             APIRequest.getImagesById,
             APIRequest.getImageData:
            return Method.GET
        case APIRequest.postLogin,
             APIRequest.postUser,
             APIRequest.postService,
             APIRequest.postServiceImage:
            return Method.POST
        case APIRequest.putService:
            return Method.PUT
        case APIRequest.deleteServiceById:
            return Method.DELETE
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
        case let APIRequest.getImageData(_, urlImage):
            let pathComponents = urlImage.pathComponents
            return "\(pathComponents![1])/\(pathComponents![2])"
        case APIRequest.postLogin:
            return "login"
        case APIRequest.postUser:
            return "users/"
        case APIRequest.postService:
            return "services/"
        case APIRequest.postServiceImage:
            return "images/"
        case let APIRequest.putService(id, _, _, _, _, _, _, _, _, _):
            return "services/\(id)"
        case let APIRequest.deleteServiceById(_, id):
            return "services/\(id)"
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case let APIRequest.getServices(_, latitude, longitude, distance, searchText, page, rows):
            if let latitude = latitude, longitude = longitude, distance = distance, searchText = searchText {
                return ["latitude": String(format:"%f", latitude),
                       "longitude": String(format:"%f", longitude),
                        "distance": String(distance),
                      "searchText": searchText,
                            "page": String(page),
                            "rows": String(rows)]
             } else {
                if let latitude = latitude, longitude = longitude, distance = distance {
                    return ["latitude": String(format:"%f", latitude),
                           "longitude": String(format:"%f", longitude),
                            "distance": String(distance),
                                "page": String(page),
                                "rows": String(rows)]
                } else {
                    if let searchText = searchText {
                        return ["searchText": searchText,
                                "page": String(page),
                                "rows": String(rows)]
                    } else {
                        return ["rows": String(rows),
                                "page": String(page)]
                    }
                }
            }
            
        case let APIRequest.getServicesByStatus(_, status, page, rows):
           return ["status": String(status), "page": String(page), "rows": String(rows)]
        
        case APIRequest.getServiceById:
            return [:]
            
        case APIRequest.getServiceImages:
            return [:]
            
        case APIRequest.getUsers:
            return [:]
            
        case APIRequest.getUserServices:
            return [:]
            
        case let APIRequest.getUserServicesByType(_, _, type, _):
             return ["type": String(type)]
        
        case APIRequest.getUserById:
            return [:]
            
        case APIRequest.getImages:
            return [:]
            
        case APIRequest.getImagesById:
            return [:]

        case APIRequest.getImageData:
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
                 "photoUrl": photoUrl != nil ? photoUrl!.absoluteString : "",
        "searchPreferences": searchPreferences != nil ? searchPreferences! : "",
                   "status": status != nil ? String(status!) : ""]
            
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
                    "price": String(price),
                     "tags": tags != nil ? tags! : "",
            "idUserRequest": idUserRequest,
                 "latitude": latitude != nil ? String(format:"%f", latitude!) : "",
                "longitude": longitude != nil ? String(format:"%f", longitude!) : "",
                  "address": address != nil ? address! : "",
                   "status": status != nil ? String(status!) : ""]
        
        case let APIRequest.postServiceImage(id: id, imageUrl: imageUrl):
        return ["idService": id,
                 "imageUrl": imageUrl.absoluteString]
        
        case let APIRequest.putService(
                         id: _,
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
                    "price": String(price),
                     "tags": tags != nil ? String.stringsToString(tags!) : "",
            "idUserRequest": idUserRequest,
                 "latitude": latitude != nil ? String(format:"%f", latitude!) : "",
                "longitude": longitude != nil ? String(format:"%f", longitude!) : "",
                  "address": address != nil ? address! : "",
                   "status": status != nil ? String(status!) : ""]
            
        case APIRequest.deleteServiceById:
            return [:]
        }
    }
}







