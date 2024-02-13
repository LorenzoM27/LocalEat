//
//  MapView.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 12/02/2024.
//

import SwiftUI
import CoreLocationUI
import MapKit

struct MapView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var manager = LocationManager()
    
    var body: some View {
        ZStack {
            mapDisplay
            searchBar
            
            
        }
    }
    
    // MARK: Private subviews
    
    private var mapDisplay : some View {
        Map(coordinateRegion: $manager.region, showsUserLocation: true)
            .ignoresSafeArea(.all)
        
    }
    
    private var searchBar : some View {
        VStack{
            Text("Search Bar")
            HStack{
                Spacer()
                requestLocation
            }
            .padding()
            
            Spacer()
        }
    }
    
    private var requestLocation : some View {
        LocationButton(.currentLocation) {
            manager.requestLocation()
            print("request")
        }
        .foregroundColor(.blue)
        .cornerRadius(25)
        .symbolVariant(.fill)
        .labelStyle(.iconOnly)
        .tint(colorScheme == .dark ? .white : .white)
        .font(.system(size: 22))
        .padding()
        
    }
}

#Preview {
    MapView()
}
