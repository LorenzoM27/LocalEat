//
//  SignUpView.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 15/02/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignUpView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    
    @State private var selectedUserType: UserType = .Client
    
    var body: some View {
        if userIsLoggedIn {
            MainView()
        } else {
            signUpBack
        }
    }
    // MARK: Private subviews
    
    private var signUpBack : some View {
        ZStack {
            background
            signUp
        }
    }
    
    private var background : some View {
        
        RoundedRectangle(cornerRadius: 30, style: .continuous)
            .foregroundStyle(.linearGradient(colors: [.green.opacity(0.4), .green], startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: 1000, height: 400)
            .rotationEffect(.degrees(135))
            .offset(x: 110, y: -670)
    }
    
    private var signUp : some View {
        
        VStack(spacing: 20) {
            Spacer()
            Text("Bienvenue")
                .foregroundStyle(.white)
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .offset(x: -90, y: -100)
            
            TextField("", text: $email)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .textFieldStyle(.plain)
                .placeholder(when: email.isEmpty) {
                    Text("Email")
                        .foregroundStyle(.green)
                        //.bold()
                }
            
            Rectangle()
                .frame(width: 350, height: 1)
                .foregroundStyle(.green)
            
            SecureField("", text: $password)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .textFieldStyle(.plain)
                .placeholder(when: password.isEmpty) {
                    Text("Mot de passe")
                        .foregroundStyle(.green)
                       // .bold()
                }
            
            Rectangle()
                .frame(width: 350, height: 1)
                .foregroundStyle(.green)
            
            Picker("UserType", selection: $selectedUserType) {
                ForEach(UserType.allCases) { userType in
                    Text(userType.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .padding(.top, 30)
            
            Spacer()
            
            Button(action: {
                register()
            }, label: {
                Text("Je créer mon compte")
                    .bold()
                    .frame(width: 200, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.linearGradient(colors: [.green.opacity(0.9), .green], startPoint: .top, endPoint: .bottomTrailing))
                    )
                    .foregroundStyle(.white)
            })
            
            Button(action: {
                login()
            }, label: {
                Text("J'ai déja un compte")
                   // .bold()
                
            })
            .padding(.bottom, 100)
        }
        .frame(width: 350)
        .onAppear {
            // Quand on se connecte, on changer la variable en true
            Auth.auth().addStateDidChangeListener { auth, user in
                
                if user != nil {
                    userIsLoggedIn.toggle()
                }
            }
        }
    }
    
    // MARK: Private functions
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}

#Preview {
    SignUpView()
}


extension View {
    func placeholder<content: View> (
        
        when shouldShow: Bool,
        alignment : Alignment = .leading,
        @ViewBuilder placeholder: () -> content) -> some View {
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
