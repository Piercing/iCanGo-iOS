//
//  Localization.swift
//  iCanGo-iOS
//
//  Created by Alberto on 30/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import Foundation

// MARK: Constants.
let loginKoTitle = "Inicio de sesion incorrecto"
let loginKoMessage = "Por favor, introduce un usuario y contraseña correctos para iniciar sesión"
let noConnectionTitle = "No hay conexion a internet"
let noConnectionMessage = "Es necesario tener conexion a internet para poder iniciar sesión"


// MARK: Time zone.
let timeZoneApp = String("GMT")


// MARK: Extensions.
extension String {
    
    static func priceToString(price: Double) -> String {

        return String(format:"%f", price)
    }
}
