//
//  Place.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 13/02/2024.
//

import SwiftUI
import MapKit

struct Place: Identifiable {
    var id = UUID().uuidString
    var place : CLPlacemark

}
