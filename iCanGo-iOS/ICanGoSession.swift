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
    
    func response(resource: Resource) -> Observable<Response> {
        
        return data(resource).map { data in
            
            guard let response: Response = decode(data) else {
                throw SessionError.CouldNotDecodeJSON
            }
            
            return response
        }
    }
}

// MARK: - Extension iCanGOS Requests
extension Session {
    
    // GET Services.
    func getServices(query: String, page: UInt, rows: UInt) -> Observable<[Service]> {
        
        return response(APIRequest.getServices(key: "", query: query, page: page, rows: rows)).map { response in
            
            return try self.returnServices(response)
        }
    }
    
    // GET Services by Status.
    func getServicesByStatus(query: String, status: String, page: UInt, rows: UInt) -> Observable<[Service]> {
        
        return response(APIRequest.getServicesByStatus(key: "", query: query, status: status, page: page, rows: rows)).map { response in
            
            return try self.returnServices(response)
        }
    }
    
    // GET Service.
    func getService(query: String) -> Observable<Service> {
        
        return response(APIRequest.getService(key: "", query: query)).map { response in
            
            return try self.returnService(response)
        }
    }
    
    // GET Users.
    func getUsers(query: String, page: UInt) -> Observable<[User]> {
        
        return response(APIRequest.getUsers(key: "", query: query, page: page)).map { response in
            
            return try self.returnUsers(response)
        }
    }
    
    // GET Services from Users.
    func getUsersServices(query: String, page: UInt) -> Observable<[Service]> {
        
        return response(APIRequest.getUsersServices(key: "", query: query, page: page)).map { response in
            
            return try self.returnServices(response)
        }
    }
    
    // GET Services from Users by Types.
    func getUsersServicesByType(query: String, type: String, page: UInt) -> Observable<[Service]> {
        
        return response(APIRequest.getUsersServicesByType(key: "", query: query, type: type, page: page)).map { response in
            
            return try self.returnServices(response)
        }
    }
    
    // GET User.
    func getUser(query: String) -> Observable<User> {
        
        return response(APIRequest.getUser(key: "", query: query)).map { response in
            
            return try self.returnUser(response)
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
                  photoUrl: String,
                  searchPreferences: String,
                  status: String) -> Observable<User> {
        
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
                     price: Double,
                     tags: [String],
                     idUserRequest: String,
                     latitude: Double,
                     longitude: Double,
                     status: String) -> Observable<Service> {
        
        return response(APIRequest.postService(name: name,
            price: price,
            tags: tags,
            idUserRequest: idUserRequest,
            latitude: latitude,
            longitude: longitude,
            status: status)).map { response in
                
                return try self.returnService(response)
        }
    }
    
    // Private responses.
    private func returnServices(response: Response) throws -> [Service] {
        
        guard response.error == "" else {
            throw SessionError.errorAPIByDescription(response.error)
        }
        
        guard let results = response.results,
            services: [Service] = decode(results) else {
                throw SessionError.CouldNotDecodeJSON
        }
        
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











