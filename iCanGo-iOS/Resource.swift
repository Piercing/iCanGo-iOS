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
    case POST = "POST"
}

protocol Resource {
    var method: Method { get }
    var path: String { get }
    var parameters: [String: String] { get }
}

// MARK: - Extension
extension Resource {
    
    var parameters: [String: String] {
        return [:]
    }
    
    func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest {
        
        let URL = baseURL.URLByAppendingPathComponent(path)
        let request: NSMutableURLRequest
        
        if method == Method.GET {
            
            guard let components = NSURLComponents(URL: URL, resolvingAgainstBaseURL: false) else {
                fatalError("Unable to create URLComponents form \(URL)")
            }
        
            components.queryItems = parameters.map { NSURLQueryItem(name: $0, value: $1) }

            guard let finalURL = components.URL else {
                fatalError("Unable to retrieve final URL")
            }
        
            request = NSMutableURLRequest(URL: finalURL)
        
        } else {
            
            request = NSMutableURLRequest(URL: URL)
        }
        
        request.HTTPMethod = method.rawValue
        if method == Method.POST {
    
            do {
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                try request.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameters, options: .PrettyPrinted)
            } catch {
                fatalError("Unable to create HTTP body data")
            }
        }
        
        return request
    }
}






