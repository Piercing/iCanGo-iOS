//
//  LocationTabViewController.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 5/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class LocationViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBarLocation: UISearchBar!
    
    let titleView = "Location"
    var locationManager: CLLocationManager?
    
    
    // MARK: - Init
    convenience init() {
        self.init(nibName: "LocationView", bundle: nil)
    }
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = Appearance.setupUI(self.view, title: self.titleView)
        self.title = title
        
        searchBarLocation.resignFirstResponder()
        
        // Configure Location Manager.
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.requestWhenInUseAuthorization()
    }
    
    override func didReceiveMemoryWarning() {
        // Dispose of any resources that can be recreated.
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Actions
    @IBAction func btnFavouritesLocation(sender: AnyObject) {
        
        // TODO:
        print("Tapp buttom favourites Location")
    }
    
    
    // Private Methods
    private func zoomIn() {
        
        var userRegion: MKCoordinateRegion = MKCoordinateRegion()
        userRegion.center.latitude = (locationManager?.location?.coordinate.latitude)!
        userRegion.center.longitude = (locationManager?.location?.coordinate.longitude)!
        userRegion.span.latitudeDelta = 0.010000
        userRegion.span.longitudeDelta = 0.010000
        mapView.setRegion(userRegion, animated: true)
    }
}


// MARK: - Extension - CLLocationManager
extension LocationViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
       
        switch status {
        case .Authorized,
             .AuthorizedWhenInUse:
            zoomIn()
            
        case .Restricted,
             .Denied:
            showAlert(noGeoUserTitle, message: noGeoUserMessage, controller: self)
            
        case .NotDetermined:
            break
        }
    }    
}


// MARK: - Extensions - Collection view delegates and datasource
extension LocationViewController: UISearchBarDelegate {
    
    func textFieldShouldReturn(searchBar: UISearchBar) -> Bool {
        
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        searchBarLocation.resignFirstResponder()
    }
}