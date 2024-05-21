//
//  SettingRowView.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 19/05/2024.
//

import SwiftUI

struct SettingsRowView: View {
    let imageName: String
    let title: String
    let tintColor: Color
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundStyle(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
    }
}

#Preview {
    SettingsRowView(imageName: "gear", title: "test", tintColor: Color(.systemGray))
}
