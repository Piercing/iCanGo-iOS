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
    var services: [Service]?
    var statusLocation: CLAuthorizationStatus?
    
    
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
        searchBarLocation.delegate = self
        
        // Configure MapView.
        mapView.delegate = self
        
        // Configure Location Manager.
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if let statusLocation = statusLocation {
            checkStatus(statusLocation)
        }
    }
    
    override func didReceiveMemoryWarning() {
        // Dispose of any resources that can be recreated.
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Actions
    @IBAction func reloadServices(sender: AnyObject) {

        if let statusLocation = statusLocation {
            checkStatus(statusLocation)
        }
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
        
        if isConnectedToNetwork() {

            let session = Session.iCanGoSession()
            // TODO: Parameter Rows pendin
            let _ = session.getServices(
                latitude,
                longitude: longitude,
                distance: distance,
                searchText: searchText,
                page: 1,
                rows: rowsPerPage)
        
                .observeOn(MainScheduler.instance)
                .subscribe { [weak self] event in
                
                    switch event {
                    case let .Next(services):
                    
                        self?.services = services
                        if self?.services?.count > 0 {
                            self?.showServicesInMap()
                        } else {
                            showAlert(serviceLocationNoTitle, message: serviceLocationNoMessage, controller: self!)
                        }
                    
                        break
                
                    case .Error (let error):
                        print(error)
                
                    default:
                        break
                    }
                }
        }
    }
    
    private func showServicesInMap() -> Void {
        
        let annotationsToRemove = mapView.annotations.filter { $0 !== mapView.userLocation }
        mapView.removeAnnotations( annotationsToRemove )
        
        for service in self.services! {
            
            let coordinate = CLLocationCoordinate2D(latitude: service.latitude!, longitude: service.longitude!)
            let serviceAnnotationMap = ServiceAnnotationMap(coordinate: coordinate, title: service.name, subtitle: "", service: service)
            mapView.addAnnotation(serviceAnnotationMap)
        }
    }
    
    private func checkStatus(status: CLAuthorizationStatus) {
     
        switch status {
        case .Authorized,
             .AuthorizedWhenInUse:
            
            if isConnectedToNetwork() {
                zoomIn()
                loadDataFromApi(locationManager?.location?.coordinate.latitude,
                     longitude: locationManager?.location?.coordinate.longitude,
                      distance: 10,
                    searchText: nil)
            }
            
        case .Restricted,
             .Denied:
            showAlert(noGeoUserTitle, message: noGeoUserMessage, controller: self)
        case .NotDetermined:
            break
        }
    }
}


// MARK: - Extension - CLLocationManager
extension LocationViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
       
        statusLocation = status
        checkStatus(status)
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

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        loadDataFromApi( locationManager?.location?.coordinate.latitude,
              longitude: locationManager?.location?.coordinate.longitude,
               distance: 10,
             searchText: searchBarLocation.text!)
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        //servicesCollectionView.fadeOut(duration: 0.3)
        return true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        //servicesCollectionView.fadeIn(duration: 0.3)
        searchBar.showsCancelButton = false
        if (searchBar.text == "") {
            //loadDataFromApi(searchBar.text!)
        }
        return true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        deActivateSearchBar()
        self.services?.removeAll()
        loadDataFromApi( locationManager?.location?.coordinate.latitude,
                         longitude: locationManager?.location?.coordinate.longitude,
                         distance: 10,
                         searchText: "")
    }
    
    func deActivateSearchBar() {
        searchBarLocation.showsCancelButton = false
        searchBarLocation.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        searchBar.setShowsCancelButton(true, animated: true)
        for ob: UIView in ((searchBar.subviews[0] )).subviews {
            
            if let z = ob as? UIButton {
                let btn: UIButton = z
                btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            }
        }
    }
}
