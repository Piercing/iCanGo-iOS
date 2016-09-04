//
//  ICanGoSession.swift
//  iCanGo-iOS
//
//  Created by Alberto on 7/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Extension Session
extension Session {
    
    // MARK: - Methods
    static func iCanGoSession() -> Session {
        return Session(baseURL: iCanGoBaseURL)
    }
    
    static func iCanGoSessionImages() -> Session {
        return Session(baseURL: iCanGoBaseURLImages)
    }
    
    func response(resource: Resource) -> Observable<Response> {
        
        return data(resource).map { data in
            
            guard let response: Response = decode(data) else {
                throw SessionError.CouldNotDecodeJSON
            }
            
            return response
        }
    }
    
    func responseData(resource: Resource) -> Observable<NSData> {
        
        return data(resource).map { data in
            return data
        }
    }
}

// MARK: - Extension iCanGOS Requests
extension Session {
    
    // GET Services.
    func getServices(latitude: Double?, longitude: Double?, distance: UInt?, searchText: String?, page: UInt, rows: UInt) -> Observable<[Service]> {
        
        return response(APIRequest.getServices(key: "",
            latitude: latitude,
            longitude: longitude,
            distance: distance,
            searchText: searchText,
            page: page,
            rows: rows)).map { response in
                return try self.returnServices(response)
        }
    }
    
    // GET Services by Status.
    func getServicesByStatus(status: UInt, page: UInt, rows: UInt) -> Observable<[Service]> {
        
        return response(APIRequest.getServicesByStatus(key: "", status: status, page: page, rows: rows)).map { response in
            
            return try self.returnServices(response)
        }
    }
    
    // GET Service.
    func getServiceById(id: String) -> Observable<Service> {
        
        return response(APIRequest.getServiceById(key: "", id: id)).map { response in
            
            return try self.returnService(response)
        }
    }
    
    // GET Service Images.
    func getServiceImages(id: String) -> Observable<[ServiceImage]> {
        
        return response(APIRequest.getServiceImages(key: "", id: id)).map { response in
            
            return try self.returnServiceImages(response)
        }
    }

    // GET Users.
    func getUsers(page: UInt) -> Observable<[User]> {
        
        return response(APIRequest.getUsers(key: "", page: page)).map { response in
            
            return try self.returnUsers(response)
        }
    }
    
    // GET Services from Users.
    func getUserServices(id: String, page: UInt) -> Observable<[Service]> {
        
        return response(APIRequest.getUserServices(key: "", id: id, page: page)).map { response in
            
            return try self.returnServices(response)
        }
    }
    
    // GET Services from Users by Types.
    func getUserServicesByType(id: String, type: UInt, page: UInt) -> Observable<[Service]> {
        
        return response(APIRequest.getUserServicesByType(key: "", id: id, type: type, page: page)).map { response in
            
            return try self.returnServices(response)
        }
    }
    
    // GET User.
    func getUserById(id: String) -> Observable<User> {
        
        return response(APIRequest.getUserById(key: "", id: id)).map { response in
            
            return try self.returnUser(response)
        }
    }
    
    // GET Images.
    func getImages() -> Observable<[ServiceImage]> {
        
        return response(APIRequest.getImages(key: "")).map { response in
            
            return try self.returnServiceImages(response)
        }
    }
    
    // GET Images by ID.
    func getImagesById(id: String) -> Observable<[ServiceImage]> {
        
        return response(APIRequest.getImagesById(key: "", id: id)).map { response in
            
            return try self.returnServiceImages(response)
        }
    }
    
    // GET Image Data.
    func getImageData(urlImage: NSURL) -> Observable<NSData> {
        
        return data(APIRequest.getImageData(key: "", urlImage: urlImage)).map { data in
        
            return data
        }
    }
    
    // GET Url SaS.
    func getUrlSaS(containerName: String, blobName: String) -> Observable<URLSaS> {
        return response(APIRequest.getUrlSaS(key: "", containerName: containerName, blobName: blobName)).map { response in
            return try self.returnUrlSaS(response)
        }
    }
    
    // POST Login.
    func postLogin(user: String, password: String) -> Observable<User> {
        
        return response(APIRequest.postLogin(user: user, password: password)).map { response in
            
            return try self.returnUser(response)
        }
    }
    
    // POST New User.
    func postUser(user: String,
              password: String,
             firstName: String,
              lastName: String,
              photoUrl: NSURL?,
     searchPreferences: String?,
                status: UInt?) -> Observable<User> {
        
        return response(APIRequest.postUser(user: user,
                                        password: password,
                                       firstName: firstName,
                                        lastName: lastName,
                                        photoUrl: photoUrl,
                               searchPreferences: searchPreferences,
                                          status: status)).map { response in
                
            return try self.returnUser(response)
        }
    }
    
    // POST New Service.
    func postService(name: String,
              description: String,
                    price: Double,
                     tags: String?,
            idUserRequest: String,
                 latitude: Double?,
                longitude: Double?,
                  address: String?,
                   status: UInt?) -> Observable<Service> {
  
        return response(APIRequest.postService(name: name,
                                        description: description,
                                              price: price,
                                               tags: tags,
                                      idUserRequest: idUserRequest,
                                           latitude: latitude,
                                          longitude: longitude,
                                            address: address,
                                             status: status)).map { response in
                
            return try self.returnService(response)
        }
    }
    
    // POST New Image to Service.
    func postServiceImage(id: String,
                    imageUrl: NSURL) -> Observable<ServiceImage> {
        
        return response(APIRequest.postServiceImage(id: id, imageUrl: imageUrl)).map { response in
                
            return try self.returnServiceImage(response)
        }
    }
    
    // PUT Update Service.
    func putService(id: String,
                  name: String,
           description: String,
                 price: Double,
                  tags: [String]?,
         idUserRequest: String,
              latitude: Double?,
             longitude: Double?,
               address: String?,
                status: UInt?) -> Observable<Service> {
        
        return response(APIRequest.putService(id: id,
                                            name: name,
                                     description: description,
                                           price: price,
                                            tags: tags,
                                   idUserRequest: idUserRequest,
                                        latitude: latitude,
                                       longitude: longitude,
                                         address: address,
                                          status: status)).map { response in
                
            return try self.returnService(response)
        }
    }
    
    func putChangeServiceStatus(id: String,
                            status: UInt,
                    idUserResponse: String) -> Observable<Service> {
        
        return response(APIRequest.putChangeServiceStatus(id: id,
                                              idUserResponse: idUserResponse,
                                                      status: status)).map { response in

            return try self.returnService(response)
        }
    }
    
    // DELETE Service.
    func deleteService(id: String) -> Observable<Service> {
        
        return response(APIRequest.deleteServiceById(key: "", id: id)).map { response in
            
            return try self.returnService(response)
        }
    }

    
    // MARK: - Private responses.
    private func returnServices(response: Response) throws -> [Service] {
        
        guard response.error == "" else {
            throw SessionError.errorAPIByDescription(response.error)
        }
        
        guard let results = response.results,
            services: [Service] = decode(results) else {
                throw SessionError.CouldNotDecodeJSON
        }
        
        totalRows = response.totalRows.hashValue
        return services
    }
    
    private func returnService(response: Response) throws -> Service {
        
        guard response.error == "" else {
            throw SessionError.errorAPIByDescription(response.error)
        }
        
        guard let result = response.result,
            service: Service = decode(result) else {
                throw SessionError.CouldNotDecodeJSON
        }
        
        return service
    }
    
    private func returnServiceImages(response: Response) throws -> [ServiceImage] {
        
        guard response.error == "" else {
            throw SessionError.errorAPIByDescription(response.error)
        }
        
        guard let results = response.results,
            serviceImages: [ServiceImage] = decode(results) else {
                throw SessionError.CouldNotDecodeJSON
        }
        
        return serviceImages
    }
    
    private func returnServiceImage(response: Response) throws -> ServiceImage {
        
        guard response.error == "" else {
            throw SessionError.errorAPIByDescription(response.error)
        }
        
        guard let result = response.result,
            serviceImage: ServiceImage = decode(result) else {
                throw SessionError.CouldNotDecodeJSON
        }
        
        return serviceImage
    }
    
    private func returnUrlSaS(response: Response) throws -> URLSaS {
        
        guard response.error == "" else {
            throw SessionError.errorAPIByDescription(response.error)
        }
        
        guard let result = response.result,
            urlSaS: URLSaS = decode(result) else {
                throw SessionError.CouldNotDecodeJSON
        }
        
        return urlSaS
    }
    
    private func returnUsers(response: Response) throws -> [User] {
        
        guard response.error == "" else {
            throw SessionError.errorAPIByDescription(response.error)
        }
        
        guard let results = response.results,
            users: [User] = decode(results) else {
                throw SessionError.CouldNotDecodeJSON
        }
        
        return users
    }
    
    private func returnUser(response: Response) throws -> User {
        
        guard response.error == "" else {
            throw SessionError.errorAPIByDescription(response.error)
        }
        
        guard let result = response.result,
            user: User = decode(result) else {
                throw SessionError.CouldNotDecodeJSON
        }
        
        return user
    }
}











