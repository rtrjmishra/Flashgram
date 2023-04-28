//
//  OnboardingView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 28/04/23.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var showOnboardingPartTwo: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            Image("uploadPageLogo")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(50)
                .shadow(radius: 20)
            
            Text("⚡️Welcome to Flashgram⚡️")
                .font(.largeTitle)
                .fontWeight(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .foregroundColor(Color.Flash.purpleColor)
            
            Text("Flashgram is an entertaining programmed application that is similar to Instagram in many ways, with the exception of chatting, which will be included in later editions!")
                .font(.headline)
                .fontWeight(.medium)
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(Color.Flash.purpleColor)
            
            Button {
                showOnboardingPartTwo.toggle()
            } label: {
                HStack {
                    Image(systemName: "globe")
                    Text("Sign in with Google")
                }
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color(.sRGB, red: 222/255, green: 82/255, blue: 70/255, opacity: 1))
                    .cornerRadius(6)
                    .accentColor(.white)
                    .font(.system(size: 23, weight: .medium, design: .default))
            }
            .padding(.vertical)
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Continue as Guest")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.Flash.purpleColor)
                    .cornerRadius(12)
                    .accentColor(Color.Flash.yellowColor)
                    .shadow(radius: 20)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.Flash.beigeColor.ignoresSafeArea())
        .fullScreenCover(isPresented: $showOnboardingPartTwo) {
            SecondOnboardingView()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
