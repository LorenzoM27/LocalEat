//
//  User.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 17/05/2024.
//

import Foundation


struct User: Identifiable, Codable {
    let id: String
    let firstName: String
    let lastName: String
    let image: String?
    let email: String
    let phone: String
//    let favorite: [Seller]?
//    let ordersHistory: [Order]?
   
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let component = formatter.personNameComponents(from: firstName + " " + lastName) {
            formatter.style = .abbreviated
            
            return formatter.string(from: component)
        }
        
        return  ""
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, 
                                firstName: "Lorenzo",
                                lastName: "Menino", 
                                image: "",
                                email: "lorenzo.menino@gmail.com",
                                phone: "0102030405")
}
