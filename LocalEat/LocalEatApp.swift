//
//  LocalEatApp.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 12/02/2024.
//

import SwiftUI
import FirebaseCore
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct LocalEatApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    
    @StateObject private var dataController = DataController()
    @StateObject var sellerDataManager = SellerDataManager()
    
//    init() {
//        FirebaseApp.configure()
//    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
            //TestFetchData()
                .environmentObject(sellerDataManager)
        }
    }
}
