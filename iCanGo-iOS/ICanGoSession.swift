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
    func getServices(query: String, page: UInt) -> Observable<[Service]> {
        
        return response(APIRequest.getServices(key: "", query: query, page: page)).map { response in
            
            guard response.error == "" else {
                throw SessionError.errorAPIByDescription(response.error)
            }

            guard let results = response.results,
            services: [Service] = decode(results) else {
                throw SessionError.CouldNotDecodeJSON
            }
        
            return services
        }
    }

    // GET Service.
    func getService(query: String) -> Observable<Service> {
        
        return response(APIRequest.getService(key: "", query: query)).map { response in
            
            guard response.error == "" else {
                throw SessionError.errorAPIByDescription(response.error)
            }
    
            guard let result = response.result,
            service: Service = decode(result) else {
                throw SessionError.CouldNotDecodeJSON
            }
            
            return service
        }
    }

    // GET Users.
    func getUsers(query: String, page: UInt) -> Observable<[User]> {

        return response(APIRequest.getUsers(key: "", query: query, page: page)).map { response in
            
            guard response.error == "" else {
                throw SessionError.errorAPIByDescription(response.error)
            }

            guard let results = response.results,
                users: [User] = decode(results) else {
                    throw SessionError.CouldNotDecodeJSON
            }
            
            return users
        }
    }
    
    // GET Users / Services.
    func getUsersServices(query: String, page: UInt) -> Observable<[Service]> {
        
        return response(APIRequest.getUsersServices(key: "", query: query, page: page)).map { response in
            
            guard response.error == "" else {
                throw SessionError.errorAPIByDescription(response.error)
            }
            
            guard let results = response.results,
                services: [Service] = decode(results) else {
                    throw SessionError.CouldNotDecodeJSON
            }
            
            return services
        }
    }

    // GET Users / Services / Types
    func getUsersServicesType(query: String, type: String, page: UInt) -> Observable<[Service]> {
        
        return response(APIRequest.getUsersServicesType(key: "", query: query, type: type, page: page)).map { response in
                
            guard response.error == "" else {
                throw SessionError.errorAPIByDescription(response.error)
            }
            
            guard let results = response.results,
                services: [Service] = decode(results) else {
                    throw SessionError.CouldNotDecodeJSON
            }
            
            return services
        }
    }

    // GET User.
    func getUser(query: String) -> Observable<User> {
     
        return response(APIRequest.getUser(key: "", query: query)).map { response in

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
    
    // POST Login.
    func postLogin(user: String, password: String) -> Observable<User> {
        
        return response(APIRequest.postLogin(user: user, password: password)).map { response in
            
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
                
            guard response.error == "" else {
                throw SessionError.errorAPIByDescription(response.error)
            }
                
            guard let result = response.result,
            service: Service = decode(result) else {
                throw SessionError.CouldNotDecodeJSON
            }
                
            return service
        }
    }
}











