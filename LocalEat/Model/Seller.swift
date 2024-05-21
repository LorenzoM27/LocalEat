//
//  Seller.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 17/05/2024.
//

import Foundation

struct Seller: Codable, Identifiable {
    
    let id : String
    let firstName : String
    let lastName : String
    let email : String
    let address : String
    let city: String
    let latitude : Double
    let longitude : Double
    let farmImage : String
    let farmName : String
    let products : [Products]?
    //  let clientOrders : [ClientOrder]?
    
}


extension Seller {
    static var MOCK_SELLERS = [
        
        Seller(id: NSUUID().uuidString,
               firstName: "Jean",
               lastName: "Dupont",
               email: "jean.dupont@gmail.com",
               address: "12 rue de la ferme",
               city: "Lille",
               latitude: 50.62675268799279,
               longitude: 3.043829431765857,
               farmImage: "farm-1",
               farmName: "Ferme du pont",
               products: [Products(id: NSUUID().uuidString, category: .fruit, title: "Orange", quantity: 1.0, image: "orange", price: 4, description: "Oranges frâiches"),
                          Products(id: NSUUID().uuidString, category: .meat, title: "Porc", quantity: 5, image: "pork", price: 25, description: "5kg de porc"),
                          Products(id: NSUUID().uuidString, category: .vegetable, title: "Salade", quantity: 1.0, image: "salad", price: 2, description: "Salade du matin")]),
        
        Seller(id: NSUUID().uuidString,
               firstName: "Jean",
               lastName: "Dupont",
               email: "jean.dupont@gmail.com",
               address: "12 rue de la ferme",
               city: "Lille",
               latitude: 50.64260975822359,
               longitude: 3.125808781133715,
               farmImage: "farm-1",
               farmName: "Ferme du pont",
               products: [Products(id: NSUUID().uuidString, category: .fruit, title: "Orange", quantity: 1.0, image: "orange", price: 4, description: "Oranges frâiches"),
                          Products(id: NSUUID().uuidString, category: .meat, title: "Porc", quantity: 5, image: "pork", price: 25, description: "5kg de porc"),
                          Products(id: NSUUID().uuidString, category: .vegetable, title: "Salade", quantity: 1.0, image: "salad", price: 2, description: "Salade du matin")]),
        
        
    ]
}
