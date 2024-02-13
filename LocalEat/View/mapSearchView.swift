//
//  MapSearchView.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 13/02/2024.
//

import SwiftUI
import CoreLocation

struct MapSearchView: View {
    
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
                Text("Search Bar")
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
    }
    
    // MARK: Private subviews
    
    private var localisationButton : some View {
        Button(action: {
            mapData.focusLocation()
        }, label: {
            Image(systemName:"location.fill")
                .font(.title2)
                .padding(10)
                .background(.white)
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
                .background(.white)
                .clipShape(Circle())
        })
    }
}

#Preview {
    MapSearchView()
}
