//
//  SellerDataManager.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 15/02/2024.
//

import Foundation
import Firebase

class SellerDataManager : ObservableObject {
    
    //@Published var seller : [Seller] = []
    @Published var seller : [SellerTest] = []
    
    init() {
        fetchSeller()
    }
    
    func fetchSeller() {
        
        seller.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("sellers")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let sellerFirstName = data["sellerFirstName"] as? String ?? ""
                    let sellerLastName = data["sellerLastName"] as? String ?? ""
                    let mail = data["mail"] as? String ?? ""
                    let address = data["address"] as? String ?? ""
                    let latitude = data["latitude"] as? Double ?? 0.0
                    let longitude = data["longitude"] as? Double ?? 0.0
                    let farmName = data["farmName"] as? String ?? ""
                    
                    let sellers = SellerTest(id: id, sellerFirstName: sellerFirstName, sellerLastName: sellerLastName, mail: mail, address: address, latitude: latitude, longitude: longitude, farmName: farmName)
                    self.seller.append(sellers)
                }
            }
        }
    }
    
}
