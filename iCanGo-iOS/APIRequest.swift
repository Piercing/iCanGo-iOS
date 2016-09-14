//
//  .swift
//  iCanGo-iOS
//
//  Created by Alberto on 6/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

enum APIRequest {
    case getServices(key: String, latitude: Double?, longitude: Double?, distance: UInt?, searchText: String?, page: UInt, rows: UInt, deleted: UInt)
    case getServicesByStatus(key: String, status: UInt, page: UInt, rows: UInt, deleted: UInt)
    case getServiceById(key: String, id: String)
    case getServiceImages(key: String, id: String)
    case getUsers(key: String, page: UInt)
    case getUserServices(key: String, id: String, page: UInt, rows: UInt)
    case getUserServicesByType(key: String, id: String, type: UInt, page: UInt, rows: UInt)
    case getUserById(key: String, id: String)
    case getImages(key: String)
    case getImagesById(key: String, id: String)
    case getImageData(key: String, urlImage: NSURL)
    case getUrlSaS(key: String, containerName: String, blobName: String)
    case postLogin(user: String, password: String)
    case postUser(user: String, password: String, firstName: String, lastName: String, photoUrl: NSURL?, searchPreferences: String?, status: UInt?)
    case postService(name: String, description: String, price: Double, tags: String?, idUserRequest: String,
         latitude: Double?, longitude: Double?, address: String?, status: UInt?)
    case postServiceImage(id: String, imageUrl: NSURL)
    case putService(id: String, name: String?, description: String?, price: Double?, tags: [String]?,
         idUserRequest: String?, latitude: Double?, longitude: Double?, address: String?, status: UInt?)
    case putChangeServiceStatus(id: String, idUserResponse: String, status: UInt)
    case putUser(id: String, firstName: String?, lastName: String?, email: String, searchPreferences: String?,
         oldPassword: String?, newPassword: String?, photoUrl: NSURL?)
    case deleteServiceById(key: String, id: String)
}

extension APIRequest: Resource {
    
    var method: Method {
        switch self {
        case .getServices,
             .getServicesByStatus,
             .getServiceById,
             .getServiceImages,
             .getUsers,
             .getUserServices,
             .getUserServicesByType,
             .getUserById,
             .getImages,
             .getImagesById,
             .getImageData,
             .getUrlSaS:
            return Method.GET
        case .postLogin,
             .postUser,
             .postService,
             .postServiceImage:
            return Method.POST
        case .putService,
             .putChangeServiceStatus,
             .putUser:
            return Method.PUT
        case .deleteServiceById:
            return Method.DELETE
        }
    }
    
    var path: String {
        switch self {
        case .getServices:
            return "services"
        case .getServicesByStatus:
            return "services"
        case let .getServiceById(_, id):
            return "services/\(id)"
        case let .getServiceImages(_, id):
            return "services/\(id)/images"
        case .getUsers:
            return "users/"
        case let .getUserServices(_, id, _, _):
            return "users/\(id)/services/"
        case let .getUserServicesByType(_, id, _, _, _):
            return "users/\(id)/services"
        case let .getUserById(_, id):
            return "users/\(id)"
        case .getImages:
            return "images"
        case let .getImagesById(_, id):
            return "images/\(id)"
        case let .getImageData(_, urlImage):
            let pathComponents = urlImage.pathComponents
            if pathComponents!.count > 2 {
                return "\(pathComponents![1])/\(pathComponents![2])"
            } else {
                if pathComponents!.count > 1 {
                    return "\(pathComponents![1])"
                } else {
                    return ""
                }
            }
        case .getUrlSaS:
            return "urlsascontainer"
        case .postLogin:
            return "login"
        case .postUser:
            return "users/"
        case .postService:
            return "services/"
        case .postServiceImage:
            return "images/"
        case let .putService(id, _, _, _, _, _, _, _, _, _):
            return "services/\(id)"
        case let .putChangeServiceStatus(id, _, _):
            return "services/\(id)/status"
        case let .putUser(id, _, _, _, _, _, _, _):
            return "users/\(id)"
        case let .deleteServiceById(_, id):
            return "services/\(id)"
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case let .getServices(_, latitude, longitude, distance, searchText, page, rows, deleted):
            if let latitude = latitude, longitude = longitude, distance = distance, searchText = searchText {
                return ["latitude": String(format:"%f", latitude),
                        "longitude": String(format:"%f", longitude),
                        "distance": String(distance),
                        "searchText": searchText,
                        "page": String(page),
                        "rows": String(rows),
                        "deleted": String(deleted)]
            } else {
                if let latitude = latitude, longitude = longitude, distance = distance {
                    return ["latitude": String(format:"%f", latitude),
                            "longitude": String(format:"%f", longitude),
                            "distance": String(distance),
                            "page": String(page),
                            "rows": String(rows),
                            "deleted": String(deleted)]
                } else {
                    if let searchText = searchText {
                        return ["searchText": searchText,
                                "page": String(page),
                                "rows": String(rows),
                                "deleted": String(deleted)]
                    } else {
                        return ["rows": String(rows),
                                "page": String(page),
                                "deleted": String(deleted)]
                    }
                }
            }
            
        case let .getServicesByStatus(_, status, page, rows, deleted):
            return ["status": String(status), "page": String(page), "rows": String(rows), "deleted": String(deleted)]
            
        case .getServiceById:
            return [:]
            
        case .getServiceImages:
            return [:]
            
        case .getUsers:
            return [:]
            
        case let .getUserServices(_, _, page, rows):
            return ["rows": String(rows), "page": String(page)]
            
        case let .getUserServicesByType(_, _, type, page, rows):
            return ["type": String(type), "rows": String(rows), "page": String(page)]
            
        case .getUserById:
            return [:]
            
        case .getImages:
            return [:]
            
        case .getImagesById:
            return [:]
            
        case .getImageData:
            return [:]
            
        case let .getUrlSaS(_, containerName, blobName):
            return ["containerName": containerName,
                    "blobName": blobName]
            
        case let .postLogin(user: user, password: password):
            return ["email": user, "password": password]
            
        case let .postUser(
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
            
        case let .postService(
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
            
        case let .postServiceImage(id: id, imageUrl: imageUrl):
            return ["idService": id,
                    "imageUrl": imageUrl.absoluteString]
            
        case let .putService(
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
            return ["name": name != nil ? name! : "",
                    "description": description != nil ? description! : "",
                    "price": price != nil ? String(price) : "",
                    "tags": tags != nil ? String.stringsToString(tags!) : "",
                    "idUserRequest": idUserRequest != nil ? idUserRequest! : "",
                    "latitude": latitude != nil ? String(format:"%f", latitude!) : "",
                    "longitude": longitude != nil ? String(format:"%f", longitude!) : "",
                    "address": address != nil ? address! : "",
                    "status": status != nil ? String(status!) : ""]
            
        case let .putChangeServiceStatus(
            id: _,
            idUserResponse: idUserResponse,
            status: status):
            return ["idUserResponse": idUserResponse,
                    "status": String(status)]

        case let .putUser(
            id: _,
            firstName: firstName,
            lastName: lastName,
            email: email,
            searchPreferences: searchPreferences,
            oldPassword: oldPassword,
            newPassword: newPassword,
            photoUrl: photoUrl):
            if let oldPassword = oldPassword, newPassword = newPassword {
                return ["oldPassword": oldPassword,
                        "password": newPassword,
                        "email": email]
            } else {
                return ["firstName": firstName != nil ? firstName! : "",
                        "lastName": lastName != nil ? lastName! : "",
                        "email": email,
                        "searchPreferences": searchPreferences != nil ? searchPreferences! : "",
                        "photoUrl": photoUrl != nil ? photoUrl!.absoluteString : ""]
            }
        
        case .deleteServiceById:
            return [:]
        }
    }
}







