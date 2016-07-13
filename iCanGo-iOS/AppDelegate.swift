//
//  AppDelegate.swift
//  iCanGo-iOS
//
//  Created by Pedro Martin Gomez on 5/6/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // Navigation Bar Style
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        test()

        self.window?.rootViewController = StartUpController(nibName: nil, bundle: nil)
        self.window?.makeKeyAndVisible()
        return true
    }
    
    
    func test() {
        
        //let url = NSURL(string: "https://icango.blob.core.windows.net/services/super2.jpg")
        
        let session = Session.iCanGoSession()
        //let _ = session.getUsers(0)
        //let _ = session.getUserById("00FFC812-0E95-4550-8CFB-FA3E20351281")
        //let _ = session.getUserServices("11366E89-5F0B-4FA3-ACCC-A273EAF0E182", page: 1)
        let _ = session.getUserServicesByType("11366E89-5F0B-4FA3-ACCC-A273EAF0E182", type: 0, page: 1)
        //let _ = session.getServices(1, rows: 5)
        //let _ = session.getServicesByStatus(0, page: 1, rows: 5)
        //let _ = session.getServiceById("00FFC812-0E95-4550-8CFB-FA3E20351281")
        //let _ = session.getServiceImages("00FFC812-0E95-4550-8CFB-FA3E20351281")
        //let _ = session.getImages()
        //let _ = session.getImagesById("856D23CD-D293-4E13-938C-1761DFF649B1")
        //let _ = session.postLogin(user: String, password: String)
        //let _ = session.postUser("alberto25@prueba.com",
        //                         password: "Alberto",
        //                         firstName: "Ortega",
        //                         lastName: "aortegas",
        //                         photoUrl: nil,
        //                         searchPreferences: nil,
        //                         status: 0)
        //let _ = session.postService("Alberto's service",
        //                         description: "Descripcion servicio Alberto",
        //                         price: 40.00,
        //                         tags: ["Albertos", "prueba40"],
        //                         idUserRequest: "11366E89-5F0B-4FA3-ACCC-A273EAF0E182",
        //                         latitude: 28.3772575,
        //                         longitude: -16.3623865,
        //                         address: "Direccion de servicio 40",
        //                         status: 2)
        //let _ = session.postServiceImage("00FFC812-0E95-4550-8CFB-FA3E20351281",
        //                        imageUrl: url!)
        //let _ = session.putService("00FFC812-0E95-4550-8CFB-FA3E20351281",
        //    name: "Service updated 3",
        //    description: "Description service updated 3",
        //    price: 25.40,
        //    tags: ["update", "3"],
        //    idUserRequest: "DAD1B764-0F20-4A1F-8D71-524E560BCEB1",
        //    latitude: 32.3772575,
        //    longitude: -17.3623865,
        //    address: "Address update 3",
        //    status: 2)

            .observeOn(MainScheduler.instance)
            .subscribe { event in
                
                switch event {
                case let .Next(services):
                    
                    //print(service)
                    
                    for service in services {
                        print(service)
                    }
                    
                    
                case .Error(let error):
                    
                    switch error {
                    case SessionError.APIErrorNoData:
                        print("No existen datos: \(error)")
                    default:
                        print(error)
                    }
                    
                default:
                    break
                }
        }
    }
    
    
}




