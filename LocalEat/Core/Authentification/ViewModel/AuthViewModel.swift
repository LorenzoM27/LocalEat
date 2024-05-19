//
//  AuthViewModel.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 17/05/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

// Form validation protocol
protocol AuthenticateFormProtocol {
    var formIsValid: Bool { get }
}


@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User? // Firebase user Object
    @Published var currentUser: User? // User
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG : Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, firstName: String, lastName: String, image: String, phone: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, firstName: firstName, lastName: lastName, image: image, email: email, phone: phone)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG : Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG :  Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
    }
    
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
}
