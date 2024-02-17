//
//  UserDataManager.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 15/02/2024.
//

import Foundation
import Firebase

class UserDataManager : ObservableObject {
    
    @Published var user : [User] = []
    
    func fetchUser() {
        
    }
    
}
