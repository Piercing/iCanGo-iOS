//
//  URLSaS.swift
//  iCanGo-iOS
//
//  Created by Pedro Martin Gomez on 3/9/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

enum JSONKeysURLSaS: String {
    case sasToken = "sasToken"
    case urlWithContainerAndBlobName = "urlWithContainerAndBlobName"
    case urlWithContainerAndWithOutBlobName = "urlWithContainerAndWithOutBlobName"
    case fullUrl = "fullUrl"
}

struct URLSaS {
    let sasToken: String
    let urlWithContainerAndBlobName: String
    let urlWithContainerAndWithOutBlobName: String
    let fullUrl: String
}

extension URLSaS: JSONDecodable {
    
    // MARK: - Init
    init?(dictionary: JSONDictionary) {
        
        guard let sasToken = dictionary[JSONKeysURLSaS.sasToken.rawValue] as? String else {
            return nil
        }
        
        guard let urlWithContainerAndBlobName = dictionary[JSONKeysURLSaS.urlWithContainerAndBlobName.rawValue] as? String else {
            return nil
        }
        
        guard let urlWithContainerAndWithOutBlobName = dictionary[JSONKeysURLSaS.urlWithContainerAndWithOutBlobName.rawValue] as? String else {
            return nil
        }
        
        guard let fullUrl = dictionary[JSONKeysURLSaS.fullUrl.rawValue] as? String else {
            return nil
        }
        
        self.sasToken = sasToken
        self.urlWithContainerAndBlobName = urlWithContainerAndBlobName
        self.urlWithContainerAndWithOutBlobName = urlWithContainerAndWithOutBlobName
        self.fullUrl = fullUrl
    }
}
