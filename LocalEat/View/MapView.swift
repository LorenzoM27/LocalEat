//
//  MapView.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 12/02/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    var body: some View {
        ZStack {
            MapDisplay
        }
    }
    
    // MARK: Private subviews
    
    private var MapDisplay: some View {
        Map()
    }
}

#Preview {
    MapView()
}
