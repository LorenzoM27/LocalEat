//
//  MainTabView.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 17/05/2024.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        TabView {
            MapView()
                .tabItem { Label("Rechercher", systemImage: "map") }
            BasketView()
                .tabItem { Label("Panier", systemImage: "basket") }
            FavoriteView()
                .tabItem { Label("Favoris", systemImage: "heart") }
            ProfilView()
                .tabItem { Label("Profil", systemImage: "person") }
                
        }
    }
}

#Preview {
    MainTabView()
}
