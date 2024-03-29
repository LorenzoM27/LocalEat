//
//  Map.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 13/02/2024.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @EnvironmentObject var mapData : MapViewModel
    
    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let view = mapData.mapView
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class Coordinator : NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // Custom Pins
            
            // Excluding user blue circle
            if annotation.isKind(of: MKUserLocation.self) { return nil}
            else {
                let pinAnnotation = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "PIN_VIEW")
                pinAnnotation.tintColor = .green
                //pinAnnotation.animatesDrop = true
                pinAnnotation.animatesWhenAdded = true
                pinAnnotation.canShowCallout = true
                
                return pinAnnotation
            }
        }
    }
}


