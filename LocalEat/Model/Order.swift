//
//  Order.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 17/05/2024.
//

import Foundation

struct Order: Codable, Identifiable {
    let id: String
    let farmName: String
    let producerName: String
    let image: String
    let title: String
    let description: String
    let category: String
    let quantity: Double
    let price: Double
    
}
