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
        let _ = session.getUsers(0)
        //let _ = session.getUser("11366E89-5F0B-4FA3-ACCC-A273EAF0E182")
        //let _ = session.getServices(page: UInt, rows: UInt)
        //let _ = session.getServicesByStatus(status: String, page: UInt, rows: UInt)
        //let _ = session.getServiceById(id: String)
        //let _ = session.getServiceImages(id: String)
        //let _ = session.getUsers(page: UInt)
        //let _ = session.getUserServices(id: String, page: UInt)
        //let _ = session.getUserServicesByType(id: String, type: String, page: UInt)
        //let _ = session.getUserById(id: String)
        //let _ = session.getImages()
        //let _ = session.getImagesById(id: String)
        //let _ = session.postLogin(user: String, password: String)
        //let _ = session.postUser(user: String,
        //                         password: String,
        //                         firstName: String,
        //                         lastName: String,
        //                         photoUrl: String,
        //                         searchPreferences: String,
        //                         status: String)
        //let _ = session.postService(session.postService("Alberto's service",
        //                        description: "Descripcion servicio Alberto",
        //                        price: 10.00,
        //                        tags: ["Albertos", "prueba"],
        //                        idUserRequest: "11366E89-5F0B-4FA3-ACCC-A273EAF0E182",
        //                        latitude: 28.3772575,
        //                        longitude: -16.3623865,
        //                        address: "Direccion de servicio",
        //                        status: 2)
        //let _ = session.postServiceImage(id: String,
        //                        imageUrl: NSURL)
        //let _ = session.putService(<#T##id: String##String#>,
        //    name: <#T##String#>,
        //    description: <#T##String#>,
        //    price: <#T##Double#>,
        //    tags: <#T##[String]?#>,
        //    idUserRequest: <#T##String#>,
        //    latitude: <#T##Double?#>,
        //    longitude: <#T##Double?#>,
        //    address: <#T##String?#>,
        //    status: <#T##Int?#>)

            .observeOn(MainScheduler.instance)
            .subscribe { event in
                
                switch event {
                case let .Next(users):
                    
                    //print(image)
                    
                    
                    for user in users {
                        print(user)
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




