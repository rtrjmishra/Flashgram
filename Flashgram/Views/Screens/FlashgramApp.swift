//
//  FlashgramApp.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 01/03/23.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct FlashgramApp: App {
    init() {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID //GSign In
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance().handle(url) //GSign In
                }
        }
    }
}
