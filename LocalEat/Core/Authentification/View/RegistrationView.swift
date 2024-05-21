//
//  RegistrationView.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 19/05/2024.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phone = ""
    
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            Spacer()
            
            VStack(spacing: 24) {
                InputView(text: $lastName, title: "Nom", placeholder: "Votre nom")
                InputView(text: $firstName, title: "Prénom", placeholder: "Votre prénom")
                InputView(text: $email, title: "Adresse mail", placeholder: "nom@exemple.fr")
                InputView(text: $phone, title: "Téléphone", placeholder: "0102030405")
                InputView(text: $password, title: "Mot de passe", placeholder: "Entrez votre mot de passe", isSecureField: true)
                ZStack(alignment: .trailing) {
                    InputView(text: $confirmPassword, title: "Confirmer mot de passe", placeholder: "Confirmer votre mot de passe", isSecureField: true)
                    
                    if !confirmPassword.isEmpty && !password.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.systemRed))
                        }
                    }
                }
            }
            .padding()
            
            Button {
                Task {
                    try await viewModel.createUser(withEmail: email, password: password, firstName: firstName, lastName: lastName, image: "", phone: phone)
                }
            } label: {
                Text("Créer un compte")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(.accent)
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.top, 24)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Déja inscrit ?")
                    Text("Connectez-vous")
                        .fontWeight(.bold)
                }
            }
            .font(.system(size: 14))
            .padding(.bottom, 10)
        }
    }
}

// MARK: - AuthenticateFormProtocol

extension RegistrationView: AuthenticateFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && password == confirmPassword
        && !firstName.isEmpty
        && !lastName.isEmpty
        && !phone.isEmpty
    }
}

#Preview {
    RegistrationView()
}
