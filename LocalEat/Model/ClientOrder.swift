//
//  ClientOrder.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 17/05/2024.
//

import Foundation

struct ClientOrder: Codable, Identifiable {
    let id: String
    let image: String
    let name: String
    let email: String
    let phone: String
    let title: String
    let category: String
    let quantity: Double
    let price: Double
    
}
