//
//  MainView.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 12/02/2024.
//

import SwiftUI

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection : $selectedTab) {
                MapSearchView()
                    .tag(0)
                BasketView()
                    .tag(1)
                FavoriteView()
                    .tag(2)
                ProfilView()
                    .tag(3)
                SettingView()
                    .tag(4)
            }

            HStack{
                ForEach((TabItems.allCases), id: \.self){ item in
                    Button{
                        selectedTab = item.rawValue
                    } label: {
                        CustomTabItem(imageName: item.iconName, isActive: (selectedTab == item.rawValue))
                    }
                }
            }
            .padding(6)
            .frame(height: 70)
            .background(colorScheme == .dark ? .white.opacity(1) : .gray.opacity(0.7))
            .cornerRadius(35)
            .padding(.horizontal, 26)
        }
        
    }
}

extension MainView {
    func CustomTabItem(imageName: String, isActive : Bool) -> some View {
        VStack{
            if isActive {
                Image(systemName: "\(imageName).fill")
                    .resizable()
                //.renderingMode(.template)
                    .foregroundStyle(.primaryAccent)
                    .frame(width : 20, height: 20)
            } else {
                Image(systemName: imageName)
                    .resizable()
                //.renderingMode(.template)
                    .foregroundStyle(colorScheme == .dark ? .gray : .white)
                    .frame(width : 20, height: 20)
            }
        }
        .frame(width: 60, height: 60)
    }
}

#Preview {
    MainView()
}
