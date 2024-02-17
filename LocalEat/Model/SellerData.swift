//
//  SellerData.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 15/02/2024.
//

import Foundation

struct Seller: Codable, Identifiable {
    
    let id : String
    let sellerFirstName : String
    let sellerLastName : String
    let mail : String
    let address : String
    let latitude : Double
    let longitude : Double
    let farmImage : String
    let farmName : String
    let products : [Products]
    let order : [Orders]
    
    struct Products : Codable, Identifiable {
        
        let id : String
        let categorie : String
        let productName : String
        let quantity : Double
        let productImage : String
        let kgPrice : Double
        let description : String
        
    }
    
    struct Orders : Codable, Identifiable {
        
        let id : String
        let customerFirstname : String
        let customerLastName : String
        let customerOrder : [CustomerOrders]
        let totalPrice : Double
        let dateOrder : String
        
    }
    
    struct CustomerOrders : Codable {
        
        let productName : String
        let orderQuantity : Double
        let price : Double
    }
}


struct SellerTest: Codable, Identifiable {
    
    let id : String
    let sellerFirstName : String
    let sellerLastName : String
    let mail : String
    let address : String
    let latitude : Double
    let longitude : Double
    let farmName : String
    
}
