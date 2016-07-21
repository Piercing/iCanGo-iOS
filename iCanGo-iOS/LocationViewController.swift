//
//  LocationTabViewController.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 5/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit
import MapKit
import RxSwift

class LocationViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBarLocation: UISearchBar!
    
    let titleView = "Location"
    var locationManager: CLLocationManager?
    private var services: [Service]?
    
    
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
        
        // Configure MapView.
        mapView.delegate = self
        
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
    
    
    // MARK: Private Methods
    private func zoomIn() {
        
        var userRegion: MKCoordinateRegion = MKCoordinateRegion()
        userRegion.center.latitude = (locationManager?.location?.coordinate.latitude)!
        userRegion.center.longitude = (locationManager?.location?.coordinate.longitude)!
        userRegion.span.latitudeDelta = 0.100000
        userRegion.span.longitudeDelta = 0.100000
        mapView.setRegion(userRegion, animated: true)
    }
    
    private func loadDataFromApi(latitude: Double?, longitude: Double?, distance: UInt?, searchText: String?) -> Void {
        
        let session = Session.iCanGoSession()
        // TODO: Parameter Rows pendin
        let _ = session.getServicesByGeoText(latitude, longitude: longitude, distance: distance, searchText: searchText, page: 1, rows: rowsPerPage)
        
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                
                switch event {
                case let .Next(services):
                    
                    self?.services = services
                    if self?.services?.count > 0 {
                        self?.showServicesInMap()
                    }
                    break
                
                case .Error (let error):
                    print(error)
                
                default:
                    break
                }
        }
    }
    
    private func showServicesInMap() -> Void {
        
        for service in self.services! {
            
            let coordinate = CLLocationCoordinate2D(latitude: service.latitude!, longitude: service.longitude!)
            let serviceAnnotationMap = ServiceAnnotationMap(coordinate: coordinate, title: service.name, subtitle: "", service: service)
            mapView.addAnnotation(serviceAnnotationMap)
        }
    }
}


// MARK: - Extension - CLLocationManager
extension LocationViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
       
        switch status {
        case .Authorized,
             .AuthorizedWhenInUse:
            zoomIn()
            loadDataFromApi(locationManager?.location?.coordinate.latitude,
                 longitude: locationManager?.location?.coordinate.longitude,
                  distance: 10,
                searchText: nil)
            
        case .Restricted,
             .Denied:
            showAlert(noGeoUserTitle, message: noGeoUserMessage, controller: self)
            
        case .NotDetermined:
            break
        }
    }    
}

extension LocationViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    
        let currentLocation = "Current Location"
        let identifier = "pin"
        
        if let annotationTitle  = annotation.title where
               annotationTitle != currentLocation {
            
            if let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) {
                annotationView.annotation = annotation
                return annotationView

            } else {
                let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
                annotationView.enabled = true
                annotationView.canShowCallout = true
                let btn = UIButton(type: .DetailDisclosure)
                annotationView.rightCalloutAccessoryView = btn
                return annotationView
            }
        
        } else {
            return nil
        }
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
     
        if let serviceAnnotationMap = view.annotation as? ServiceAnnotationMap {
            
            let detailServiceViewController = DetailServiceViewController(service: serviceAnnotationMap.service)
            print(self.navigationController)
            self.navigationController?.pushViewController(detailServiceViewController, animated: true)
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