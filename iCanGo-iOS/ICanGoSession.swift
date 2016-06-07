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

    func getObjects<T: JSONDecodable>(resource: Resource) -> Observable<[T]> {
        
        // Observable secuence <NSData> -> Observable secuence <[T]>
        return data(resource).map { data in
            
            guard let objects: [T] = decode(data) else {
                throw SessionError.CouldNotDecodeJSON
            }
                        
            return objects
        }
    }
}

// MARK: - Extension iCanGOS Requests
extension Session {

    func getServices(query: String) -> Observable<[Service]> {
        return getObjects(APIRequest.GetServices(key: "", query: query))
    }
}

