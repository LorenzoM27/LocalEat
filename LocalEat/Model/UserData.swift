//
//  UserData.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 15/02/2024.
//

import Foundation

struct User : Codable, Identifiable {
    
    let id : String
    let firstName : String
    let lastName : String
    let mail : String
    let favorite : [Seller]
    let ordersHistory : [OrdersHistory]
    
    struct OrdersHistory : Codable, Identifiable {
        
        let id : String
        let order : [Orders]
        let farmName : String
        let totalPrice : Double
    }
    
    struct Orders : Codable {
        
        let productName : String
        let orderQuantity : Double
        let price : Double
    }
}
