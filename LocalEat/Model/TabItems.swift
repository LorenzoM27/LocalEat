//
//  TabbedItems.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 12/02/2024.
//

import Foundation


enum TabbedItems : Int, CaseIterable {
    
    case map =  0
    case basket
    case favorite
    case profil
    case setting
    
    var iconName : String {
        
        switch self {
        case .map :
            return "carrot"
        case .basket :
            return "basket"
        case .favorite :
            return "heart"
        case .profil :
            return "person"
        case .setting :
            return "gearshape"
        }
    }
}
