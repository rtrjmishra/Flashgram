//
//  SettingsEditTextView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 27/04/23.
//

import SwiftUI

struct SettingsEditTextView: View {
    @State var title: String = ""
    @State var description: String = ""
    @State var submissionText: String = ""
    @State var placeholder: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(description)
                Spacer(minLength: 0)
            }
            
            TextField(placeholder, text: $submissionText)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.Flash.beigeColor)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
            
            Button {
            } label: {
                Text("Save".uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.Flash.purpleColor)
                    .cornerRadius(12)
                    .accentColor(Color.Flash.yellowColor)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationTitle(title)
    }
}

struct SettingsEditTextView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsEditTextView()
        }
    }
}
