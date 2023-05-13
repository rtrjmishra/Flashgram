//
//  SignInWithGoogle.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 29/04/23.
//

import Foundation
import UIKit
import SwiftUI
import GoogleSignIn
import FirebaseAuth
import FirebaseFirestore

class SignInWithGoogle: NSObject, GIDSignInDelegate {
    static let shared = SignInWithGoogle()
    var onboardingView: OnboardingView!

    func startSignInWithGoogleFlow(view: OnboardingView) { //1
        
        self.onboardingView = view
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().presentingViewController = UIApplication.shared.windows.first?.rootViewController
        GIDSignIn.sharedInstance().presentingViewController.modalPresentationStyle = .fullScreen
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) { //2
        if let error = error {
            print("Error signing in with google \(error)")
            self.onboardingView.showError.toggle()
            return
        }
        
        let name: String = user.profile.name
        let email: String = user.profile.email
        
        let idToken: String = user.authentication.idToken
        let accessToken: String = user.authentication.accessToken
        let cred = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        self.onboardingView.connectToFirebase(name: name, email: email, provider: "Google", cred: cred)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) { //not success => error
        print("User Disconnected from google")
        self.onboardingView.showError.toggle()
    }
    
}
