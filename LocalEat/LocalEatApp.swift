//
//  LocalEatApp.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 17/05/2024.
//

import SwiftUI

@main
struct LocalEatApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
