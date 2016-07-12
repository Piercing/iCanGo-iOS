//
//  Localization.swift
//  iCanGo-iOS
//
//  Created by Alberto on 30/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

// MARK: Constants.
let loginKoTitle = "Wrong login"
let loginKoMessage = "Please, enter a valid email and password"
let noConnectionTitle = "No internet connection"
let noConnectionMessage = "An Internet connection is needed to log in"


// MARK: Time zone.
let timeZoneApp = String("GMT")


// MARK: Extensions.
extension String {
    
    static func priceToString(price: Double) -> String {

        return String(format:"%f", price)
    }
}
