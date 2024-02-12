//
//  MapView.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 12/02/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var manager = LocationManager()
    
    var body: some View {
        ZStack {
            MapDisplay()
            searchBar
            
        }
    }
    
    // MARK: Private subviews
    
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
        Button {
            manager.requestLocation()
        } label: {
            Circle()
                .foregroundColor(colorScheme == .dark ? .white.opacity(0.6) : .white.opacity(0.8))
                .frame(width: 50, height: 50)
                .overlay {
                    Image(systemName: "location.fill")
                        .imageScale(.large)
                        .bold()
                        .frame(width: 50, height: 50)
                }
                .padding()
            
        }

    }
}

#Preview {
    MapView()
}
