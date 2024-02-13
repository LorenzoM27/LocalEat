//
//  MapSearchView.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 13/02/2024.
//

import SwiftUI
import CoreLocation

struct MapSearchView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var mapData = MapViewModel()
    // Location manager
    @State var locationManager = CLLocationManager()
    
    var body: some View {
        
        ZStack {
            MapView()
            // Using it as environment object so that it can be used ints subViews
                .environmentObject(mapData)
                .ignoresSafeArea(.all)
            
            VStack {
                searchBox
                HStack {
                    Spacer()
                    VStack {
                        localisationButton
                        mapTypeButton
                    }
                    .padding()
                }
                Spacer()
            }
            
        }
        .onAppear(perform: {
            // Setting delegate
            locationManager.delegate = mapData
            locationManager.requestWhenInUseAuthorization()
        })
        // permission Denied alert
        .alert(isPresented: $mapData.permissionDenied, content: {
            Alert(title: Text("Accès refusé"), message: Text("Nous avons besoin de votre localisation. S'il vous plait allez dans les paramètres"), dismissButton: .default(Text("Allez aux paramètres"), action: {
                // Redirecting user to setting
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
        })
        .onChange(of: mapData.searchTxt, perform: { value in
            // searching places
            
            // You can use your own delay time to avoid Continuous Search request
            let delay = 0.3
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if value  == mapData.searchTxt {
                    // search ...
                    self.mapData.searchQuery()
                }
            }
        })
    }
    
    // MARK: Private subviews
    
    private var searchBox : some View {
        VStack(spacing: 1) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
                TextField("Rechercher", text: $mapData.searchTxt)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(colorScheme == .dark ? .white.opacity(0.4) : .white)
            .cornerRadius(20)
            
            // Displaying results ...
            
            if !mapData.places.isEmpty && mapData.searchTxt != "" {
                ScrollView {
                    VStack(spacing : 15) {
                        ForEach(mapData.places) { place in
                            Text(place.place.name ?? "")
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                                .onTapGesture {
                                    mapData.selectPlaces(place: place)
                                }
                            
                            Divider()
                        }
                    }
                    .padding(.top)
                }
                .background(.white)
            }
        
        }
        .padding()
    }
    
    private var localisationButton : some View {
        Button(action: {
            mapData.focusLocation()
        }, label: {
            Image(systemName:"location.fill")
                .font(.title2)
                .padding(10)
                .background(colorScheme == .dark ? .white.opacity(0.4) : .white)
                .clipShape(Circle())
        })
    }
    
    
    private var mapTypeButton : some View {
        Button(action: {
            mapData.updateMapType()
        }, label: {
            Image(systemName: mapData.mapType == .standard ? "network": "map")
                .font(.title2)
                .padding(10)
                .background(colorScheme == .dark ? .white.opacity(0.4) : .white)
                .clipShape(Circle())
        })
    }
}

#Preview {
    MapSearchView()
}
