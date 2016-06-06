//
//  Resource.swift
//  iCanGo-iOS
//
//  Created by Alberto on 6/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

enum Method: String
{
    case GET = "GET"
}

protocol Resource {
    var method: Method { get }
    var path: String { get }
    var parameters: [String: String] { get }
}

extension Resource {
    
    var parameters: [String: String] {
        return [:]
    }
    
    func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest {
        
        let URL = baseURL.URLByAppendingPathComponent(path)
        
        guard let components = NSURLComponents(URL: URL, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URLComponents form \(URL)")
        }
        
        components.queryItems = parameters.map { NSURLQueryItem(name: $0, value: $1) }
        
        guard let finalURL = components.URL else {
            fatalError("Unable to retrieve final URL")
        }
        
        let request = NSMutableURLRequest(URL: finalURL)
        request.HTTPMethod = method.rawValue
        return request
    }
}