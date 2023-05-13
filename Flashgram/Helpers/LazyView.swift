//
//  LazyView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 13/05/23.
//

import SwiftUI

struct LazyView<Content: View>: View {
    var content: () -> Content
    
    var body: some View {
        self.content()
    }
}
