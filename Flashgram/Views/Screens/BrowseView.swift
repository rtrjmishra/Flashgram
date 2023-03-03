//
//  BrowseView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 04/03/23.
//

import SwiftUI

struct BrowseView: View {
    var posts = PostArrayObject()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            CarouselView()
            ImageGridView(posts: posts)
        }
        .navigationTitle("Browse")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BrowseView()
        }
    }
}
