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
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var updatePins: UIButton!
    
    private var services: [Service]?
    private var locationManager: CLLocationManager?
    private var statusLocation: CLAuthorizationStatus?
    private var requestDataInProgress: Bool = false
    private var updatingLocation: Bool = true
    private var numberUpdatesPosition: UInt = 0
    
    
    // MARK: - Init
    convenience init() {
        self.init(nibName: "LocationView", bundle: nil)
        
        // Add as observer
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LocationViewController.refreshServiceInMap(_:)),
                                                         name: notificationKeyServicesChange,
                                                         object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: notificationKeyServicesChange, object: nil)
    }

    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Appearance.setupUI(self.view, title: locationTitleVC)
        
        // Initialize variables.
        services = [Service]()
        searchBarLocation.resignFirstResponder()
        searchBarLocation.delegate = self
        activityIndicatorView.hidden = true
        
        // Configure MapView.
        mapView.delegate = self
        
        // Configure Location Manager.
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()
        updatingLocation = true
        numberUpdatesPosition = 0
    }
    
    override func viewWillAppear(animated: Bool) {
        checkStatusAndGetData(statusLocation, searchText: nil)
    }
    
    override func didReceiveMemoryWarning() {
        // Dispose of any resources that can be recreated.
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: Notification Methods
    func refreshServiceInMap(notification: NSNotification) {
        checkStatusAndGetData(statusLocation, searchText: searchBarLocation.text == "" ? nil : searchBarLocation.text)
    }

    
    // MARK: - Actions
    @IBAction func reloadServices(sender: AnyObject) {
        checkStatusAndGetData(statusLocation, searchText: searchBarLocation.text == "" ? nil : searchBarLocation.text)
    }
    
    @IBAction func findMyPosition(sender: AnyObject) {
        
        if checkLocationStatus(statusLocation!) {
            if !updatingLocation {
                
                locationManager?.startUpdatingLocation()
                updatingLocation = true
                numberUpdatesPosition = 0
            }
            
            zoomToMyPosition()
        }
    }
    
    
    // MARK: - Private Methods
    private func getDataFromApi(latitude: Double?, longitude: Double?, distance: UInt?, searchText: String?) -> Void {
        
        if !isConnectedToNetwork() {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
            return
        }

        if requestDataInProgress {
            return
        }
        
        requestDataInProgress = true
        starActivityIndicator()
        
        let session = Session.iCanGoSession()
        let _ = session.getServices(
            latitude,
            longitude: longitude,
            distance: distance,
            searchText: searchText,
            page: 1,
            rows: rowsPerPage)
            
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                
                self!.stopActivityIndicator()
                
                switch event {
                case let .Next(services):
                    self?.requestDataInProgress = false
                    self?.services = services
                    if self?.services?.count > 0 {
                        self?.showServicesInMap()
                    } else {
                        showAlert(serviceLocationNoTitle, message: serviceLocationNoMessage, controller: self!)
                    }
                    
                case .Error (let error):
                    self?.requestDataInProgress = false
                    print(error)
                    
                default:
                    self?.requestDataInProgress = false
                }
        }
        
    }

    private func starActivityIndicator() {
        
        actionStarted(activityIndicatorView)
        updatePins.enabled = false
        updatePins.hidden = true
    }
    
    private func stopActivityIndicator() {
        
        actionFinished(activityIndicatorView)
        updatePins.enabled = true
        updatePins.hidden = false
    }

    private func showServicesInMap() -> Void {
        
        let annotationsToRemove = mapView.annotations.filter { $0 !== mapView.userLocation }
        mapView.removeAnnotations( annotationsToRemove )
        
        for service in services! {
            
            let coordinate = CLLocationCoordinate2D(latitude: service.latitude!, longitude: service.longitude!)
            let serviceAnnotationMap = ServiceAnnotationMap(coordinate: coordinate, title: service.name, subtitle: "", service: service)
            mapView.addAnnotation(serviceAnnotationMap)
        }
    }

    private func checkStatusAndGetData(status: CLAuthorizationStatus?, searchText: String?) {
        
        guard let status = status else {
            return
        }
        
        if !checkLocationStatus(status) {
            return
        }
        
        services?.removeAll()
        showServicesInMap()
        getData(searchText)
    }

    private func checkLocationStatus(status: CLAuthorizationStatus) -> Bool {
        
        if status == .NotDetermined {
            locationManager?.requestWhenInUseAuthorization()
            return false
        }
        
        if status != .AuthorizedAlways && status != .AuthorizedWhenInUse {
            showAlert(noGeoUserTitle, message: noGeoUserMessage, controller: self)
            return false
        }
        
        return true
    }

    private func getData(searchText: String?) {
        
        // Programación defensiva
        guard let latitude = locationManager?.location?.coordinate.latitude, longitude = locationManager?.location?.coordinate.longitude else {
            return
        }
        
        getDataFromApi(latitude, longitude: longitude, distance: distanceSearchService, searchText: searchText == nil ? searchText : searchText!)
    }

    private func zoomToMyPosition() {
        
        if statusLocation == CLAuthorizationStatus.AuthorizedAlways || statusLocation == CLAuthorizationStatus.AuthorizedWhenInUse {
            
            var userRegion: MKCoordinateRegion = MKCoordinateRegion()
            userRegion.center.latitude = (locationManager?.location?.coordinate.latitude)!
            userRegion.center.longitude = (locationManager?.location?.coordinate.longitude)!
            userRegion.span.latitudeDelta = spanInMap
            userRegion.span.longitudeDelta = spanInMap
            mapView.setRegion(userRegion, animated: true)
        }
    }
}


// MARK: - Extension - CLLocationManager
extension LocationViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
       
        statusLocation = status
        checkStatusAndGetData(status, searchText: nil)
        zoomToMyPosition()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if (numberUpdatesPosition < maxUpdatesPosition) {
            numberUpdatesPosition += 1
        } else {
            locationManager?.stopUpdatingLocation()
            updatingLocation = false
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
        
        searchBar.endEditing(true)
        checkStatusAndGetData(statusLocation, searchText: searchBarLocation.text!)
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {

        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {

        searchBar.showsCancelButton = false
        return true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        deActivateSearchBar()
        searchBar.text = ""
        checkStatusAndGetData(statusLocation, searchText: nil)
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
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if services?.count != 0 {
            services?.removeAll()
            showServicesInMap()
        }
    }
}


