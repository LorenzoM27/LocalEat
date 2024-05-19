//
//  FavoriteView.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 17/05/2024.
//

import SwiftUI

struct FavoriteView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        Group {
            if viewModel.userSession != nil {
                Text("FavoriteView")
            } else {
                LoginView()
            }
        }

        //Text("favorite")
    }
}

#Preview {
    FavoriteView()
}
