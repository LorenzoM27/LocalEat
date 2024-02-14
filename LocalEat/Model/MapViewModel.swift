//
//  MapViewModel.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 13/02/2024.
//

import SwiftUI
import MapKit
import CoreLocation

// All map data goes here

class MapViewModel : NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var mapView = MKMapView()
    // Region ...
    @Published var region : MKCoordinateRegion!
    // Based on location it will set up
    
    // Alert
    @Published var permissionDenied = false
    
    // map Type
    @Published var mapType : MKMapType = .standard
    
    // Search Text
    @Published var searchTxt = ""
    
    // Search Places ...
    @Published var places : [Place] = []
    
    // updating map type
    func updateMapType() {
        
        if mapType == .standard {
            mapType = .hybrid
            mapView.mapType = mapType
        } else {
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
    // Focus location
    func focusLocation() {
        guard let _ = region else {return}
        
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    // Search Places ...
    func searchQuery(){
        
        places.removeAll()
        
        let request  = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTxt
        
        // Fetch...
        MKLocalSearch(request: request).start { response, _ in
            guard let result = response else {return}
            
            self.places = result.mapItems.compactMap({ item in
                return Place(place: item.placemark)
            })
        }
    }
    
    // Pick search Result...
    func selectPlaces(place: Place) {
        // Showing pin on map
        searchTxt = ""
        
        guard let coordinate = place.place.location?.coordinate else {return}
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.place.name ?? "Sans Nom"
        
        // Removing all old ones
        mapView.removeAnnotations(mapView.annotations)
        
        mapView.addAnnotation(pointAnnotation)
        
        // Moving Map to that Location
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Cheking Permissions
        
        switch manager.authorizationStatus {
        case .denied:
            // Alert
            permissionDenied.toggle()
        case .notDetermined:
            //Requesting
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            // if permission given
            manager.requestLocation()
        default:
            ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        // Error
        print(error.localizedDescription)
    }
    
    // Getting user region
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {return}
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        // udating map
        self.mapView.setRegion(self.region, animated: true)
        // smooth animation
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
    
    
}

