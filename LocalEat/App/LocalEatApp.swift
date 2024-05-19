//
//  LocalEatApp.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 17/05/2024.
//

import SwiftUI
import Firebase

@main
struct LocalEatApp: App {
    
    @StateObject var viewModel = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
