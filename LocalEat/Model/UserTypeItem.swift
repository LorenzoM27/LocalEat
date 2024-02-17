//
//  UserTypeItem.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 15/02/2024.
//

import Foundation

enum UserType: String, CaseIterable, Identifiable {
    case Client, Producteur
    var id: Self { self }
}
