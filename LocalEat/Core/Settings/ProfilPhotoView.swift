//
//  ProfilPhotoView.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 21/05/2024.
//

import SwiftUI

struct ProfilPhotoView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        
        if let user = viewModel.currentUser {
            ZStack(alignment: .bottomTrailing) {
                if user.image != "" {
                    Image(user.image)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                } else {
                    Text(user.initials)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray3))
                        .clipShape(Circle())
                }
                
               Circle()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(Color(.lightGray))
                    .opacity(0.8)
                    .overlay {
                        Image(systemName: "pencil")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 15, height: 15)
                    }
            }
            
        }
    }
}

#Preview {
    ProfilPhotoView()
}
