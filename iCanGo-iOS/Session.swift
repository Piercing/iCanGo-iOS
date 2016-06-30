//
//  Session.swift
//  iCanGo-iOS
//
//  Created by Alberto on 7/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation
import RxSwift

enum SessionError: ErrorType {
    case CouldNotDecodeJSON
    case BadHTTPStatus(status: Int)
    case NoData(error: String)
    case Other(NSError)
}


extension SessionError: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .CouldNotDecodeJSON:
            return "Could not decode JSON"
        case let .BadHTTPStatus(status):
            return "Bad Status: \(status)"
        case let .NoData(error):
            return error
        case let .Other(error):
            return "Other error: \(error)"
        }
    }
}

final class Session
{
    // MARK: - Private properties
    private let session: NSURLSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    private let baseURL: NSURL
    
    
    // MARK: - Init
    init(baseURL: NSURL) {
        self.baseURL = baseURL
    }
    
    
    // MARK: - Methods
    func data(resource: Resource) -> Observable<NSData> {

        let request = resource.requestWithBaseURL(baseURL)
        
        return Observable.create { observer in
            
            let task = self.session.dataTaskWithRequest(request) { data, response, error in
                
                if let error = error {
                    
                    observer.onError(SessionError.Other(error))
                
                } else {
                    
                    guard let HTTPResponse = response as? NSHTTPURLResponse else {
                        fatalError("Couldn't get HTTP response")
                    }

                    if 200 ..< 300 ~= HTTPResponse.statusCode {
                        observer.onNext(data ?? NSData())
                        observer.onCompleted()
                    
                    } else {
                        observer.onError(SessionError.BadHTTPStatus(status: HTTPResponse.statusCode))
                    }
                }
            }
            
            task.resume()
            
            return AnonymousDisposable {
                task.cancel()
            }
        }
    }
}



