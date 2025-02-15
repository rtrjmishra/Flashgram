//
//  ProfileHeaderView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 09/04/23.
//

import SwiftUI

struct ProfileHeaderView: View {
    @Binding var profileDisplayName: String
    @Binding var profileImage: UIImage
    @Binding var profileBio: String
    @ObservedObject var postArray: PostArrayObject
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            //Profile Image
            Image(uiImage: profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120, alignment: .center)
                .cornerRadius(60)
            
            //Username
            Text(profileDisplayName)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            //Bio
            if !profileBio.isEmpty {
                Text(profileBio)
                    .font(.body)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
            }
            
            HStack(alignment: .center, spacing: 20) {
                //Posts
                VStack(alignment: .center, spacing: 5) {
                    Text(postArray.postCountString)
                        .font(.title2)
                        .fontWeight(.bold)
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 20, height: 2, alignment: .center)
                    Text("Posts")
                        .font(.callout)
                        .fontWeight(.medium)
                }
                
                //Likes
                VStack(alignment: .center, spacing: 5) {
                    Text(postArray.likeCountString)
                        .font(.title2)
                        .fontWeight(.bold)
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 20, height: 2, alignment: .center)
                    Text("Likes")
                        .font(.callout)
                        .fontWeight(.medium)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(profileDisplayName: .constant("Test!"),
                          profileImage: .constant(UIImage(systemName: "person")!), profileBio: .constant("Test Bio!"),
                          postArray: PostArrayObject(shuffled: true))
    }
}
