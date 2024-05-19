//
//  ProfilView.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 19/05/2024.
//

import SwiftUI

struct ProfilView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        
        Group {
            if viewModel.userSession != nil {
                if let user = viewModel.currentUser {
                    NavigationStack {
                        List {
                            Section {
                                HStack {
                                    Text(user.initials)
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                        .frame(width: 72, height: 72)
                                        .background(Color(.systemGray3))
                                        .clipShape(Circle())
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(user.firstName + " " + user.lastName)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .padding(.top, 4)
                                        Text(user.email)
                                            .font(.footnote)
                                            .foregroundStyle(.gray)
                                        Text(user.phone)
                                            .font(.footnote)
                                            .foregroundStyle(.gray)
                                    }
                                }
                            }
                            Section("Général") {
                                Text("Photo de profil")
                                Text("Historique achats")
                            }
                            Section("Compte") {
                                Button {
                                    viewModel.signOut()
                                } label: {
                                    SettingsRowView(imageName: "arrow.left.circle.fill",
                                                    title: "Déconnexion",
                                                    tintColor: .red)
                                }
                                
                                Button {
                                    viewModel.deleteAccount()
                                } label: {
                                    SettingsRowView(imageName: "xmark.circle.fill",
                                                    title: "Supprimer compte",
                                                    tintColor: .red)
                                }
                            }
                        }
                    }
                }
                
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ProfilView()
}
