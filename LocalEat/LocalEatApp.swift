//
//  LocalEatApp.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 12/02/2024.
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
