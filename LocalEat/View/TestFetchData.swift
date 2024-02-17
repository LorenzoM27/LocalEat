//
//  TestFetchData.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 15/02/2024.
//

import SwiftUI

struct TestFetchData: View {
    
    @EnvironmentObject var sellerDataManager : SellerDataManager
    
    var body: some View {
        NavigationView {
            List(sellerDataManager.seller, id: \.id) { seller in
                Text(seller.mail)
            }
            .navigationTitle("Seller")
        }
    }
}

#Preview {
    TestFetchData()
}
