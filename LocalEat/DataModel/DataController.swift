//
//  DataController.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 12/02/2024.
//

import Foundation
import CoreData

class DataController : ObservableObject {
    
    let container = NSPersistentContainer(name: "BasketModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if error != nil {
                print("Failed to load data")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        
        do {
            try context.save()
            print("data saved")
        } catch {
            print("Unable to save")
        }
    }
    
}
