//
//  LikeAnimationView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 28/04/23.
//

import SwiftUI

struct LikeAnimationView: View {
    @Binding var animate: Bool
    
    var body: some View {
        ZStack {
            Image(systemName: "heart.fill")
                .foregroundColor(Color.red.opacity(0.5))
                .font(.system(size: 75))
                .opacity(animate ? 1 : 0)
                .scaleEffect(animate ? 1 : 0.15)
        }
        .animation(.easeInOut(duration: 0.5))
    }
}

struct LikeAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        LikeAnimationView(animate: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
