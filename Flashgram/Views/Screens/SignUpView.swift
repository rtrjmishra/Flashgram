//
//  SignUpView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 27/04/23.
//

import SwiftUI

struct SignUpView: View {
    @State var showOnboarding: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            Spacer()
            
            Image("onboardingLogo")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(50)
                .shadow(radius: 20)
            
            Text("You are not Signed In 😔")
                .font(.largeTitle)
                .fontWeight(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .foregroundColor(Color.Flash.beigeColor)
            
            Text("Click the button below to create an account and join the family")
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.Flash.beigeColor)
            
            Button {
                showOnboarding.toggle()
            } label: {
                Text("Sign In / Sign Up".uppercased())
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.Flash.yellowColor)
                    .cornerRadius(12)
                    .accentColor(Color.Flash.purpleColor)
                    .padding(.horizontal, 50)
                    .shadow(radius: 20)
            }
            
            Spacer()
            Spacer()
        }
        .padding(40)
        .background(Color.Flash.purpleColor).edgesIgnoringSafeArea(.top)
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingView()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
