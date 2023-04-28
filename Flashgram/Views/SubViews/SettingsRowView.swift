//
//  SettingsRowView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 16/04/23.
//

import SwiftUI

struct SettingsRowView: View {
    var leftIcon: String
    var text: String
    var color: Color
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(color)
                Image(systemName: leftIcon)
                    .font(.title2)
                    .foregroundColor(.white)
            }
            .frame(width: 35, height: 35, alignment: .center)
            
            Text(text)
                .foregroundColor(.primary)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.headline)
                .foregroundColor(.primary)
            
        }
        .padding(.vertical, 4)
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(leftIcon: "heart.fill", text: "Demo", color: .purple)
    }
}
