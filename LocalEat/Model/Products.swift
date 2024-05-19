//
//  Products.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 17/05/2024.
//

import Foundation


struct Products : Codable, Identifiable {
    
    let id : String
    let category : CategoryTypes
    let title : String
    let quantity : Double
    let image : String
    let price : Double
    let description : String
    
}

enum CategoryTypes: Int, Codable, Identifiable, Hashable {
    
    case vegetable
    case fruit
    case meat
    case poultry
    
    var description: String {
        switch self {
        case .vegetable: return "Légume"
        case .fruit: return "Fruit"
        case .meat: return "Viande"
        case .poultry: return "Volaille"
        }
    }
    var id: Int { return self.rawValue }
}
