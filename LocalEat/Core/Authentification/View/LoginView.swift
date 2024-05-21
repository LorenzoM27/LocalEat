//
//  LoginView.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 17/05/2024.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                Spacer()
                
                // Form fields
                    VStack(spacing: 24) {
                        InputView(text: $email, title: "Adresse mail", placeholder: "nom@exemple.fr")
                        InputView(text: $password, title: "Mot de passe", placeholder: "Entrez-votre mot de passe", isSecureField: true)
                        
                    }
                    
                // SignIn button
                    Button {
                        Task {
                            try await viewModel.signIn(withEmail: email, password: password)
                        }
                       
                    } label: {
                        Text("Connexion")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    }
                    .background(.accent)
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 24)
                
                Spacer()
                
                // RegistrationView Link
                VStack {
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        HStack {
                            Text("Pas encore inscrit ?")
                            Text("Créer un compte")
                                .fontWeight(.bold)
                        }
                    }
                    .font(.system(size: 14))
                }
                .padding(.bottom, 10)
            }
            .padding()
        }
    }
}

// MARK: - AuthenticateFormProtocol

extension LoginView: AuthenticateFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}


#Preview {
    LoginView()
}
