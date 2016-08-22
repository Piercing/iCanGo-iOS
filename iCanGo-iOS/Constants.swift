//
//  Constants.swift
//  iCanGo-iOS
//
//  Created by Alberto on 7/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

// Model - Network
let iCanGoBaseURL = NSURL(string: "https://icangopmg-develop.azurewebsites.net/api/v1")!
let iCanGoBaseURLImages = NSURL(string: "https://icango.blob.core.windows.net")!

let rowsPerPage: UInt = 25 // number of rows that will be included in the data page retrieved from API
let widthReducedImage: CGFloat = 600.0 // final size for images reduced
let distanceSearchService: UInt = 10 // distance to search services around
let spanInMap: Double = 0.100000

