//
//  MapDisplay.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 12/02/2024.
//

import SwiftUI
import MapKit

struct MapDisplay: View {
    
    // Nous ajouterons un @StateObject (ou @ObservedObject si vous utilisez iOS13) pour recevoir les mises à jour de la région.
    @StateObject var manager = LocationManager()
    
    var body: some View {
        Map(coordinateRegion: $manager.region, showsUserLocation: true)
            .ignoresSafeArea(.all)
    }
}

#Preview {
    MapDisplay()
}
