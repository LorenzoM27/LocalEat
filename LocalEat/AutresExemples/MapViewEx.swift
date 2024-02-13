//
//  MapView.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 12/02/2024.
//

import SwiftUI
import CoreLocationUI
import MapKit

struct MapViewEx: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var manager = LocationManager()
    //MKMapView.appearance().mapType = .hybrid
    @State private var isMapTypeChange = false
    
    var body: some View {
        ZStack {
            mapDisplay
            VStack{
                searchBar()
                HStack {
                    Spacer()
                    VStack{
                        requestLocation
                        mapType
                    }
                }
                .padding(20)
                
                Spacer()
            }
            
        }
    }
    
    // MARK: Private subviews
    
    private var mapDisplay : some View {
        Map(coordinateRegion: $manager.region, showsUserLocation: true)
            .ignoresSafeArea(.all)
    }
    
    private struct searchBar : View {
        
        var body : some View {
            Text("Search Bar")
        }
    }
   
    
    
    private var mapType : some View {
        Button {
            isMapTypeChange.toggle()
            print("type change")
        } label: {
            Circle()
                .foregroundStyle(.white)
                .frame(width:50, height: 50)
                .overlay {
                    Image(systemName: "map.fill")
                        .imageScale(.large)
                }
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
        //.padding()
        
    }
    
    
}

#Preview {
    MapViewEx()
}
