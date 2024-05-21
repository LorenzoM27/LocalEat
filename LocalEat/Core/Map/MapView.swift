//
//  MapView.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 17/05/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    var body: some View {
        Map() {
            ForEach(Seller.MOCK_SELLERS) { coordinate in
                Marker(coordinate.farmName, coordinate: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
                    .tint(.green)
                }
        }
        .mapControls {
            MapPitchToggle()
            MapUserLocationButton()
        }
          
    }
}

#Preview {
    MapView()
}
