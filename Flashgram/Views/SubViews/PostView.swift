//
//  PostView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 03/03/23.
//

import SwiftUI

struct PostView: View {
    @State var postModel: PostModel
    var showHeaderAndFooter: Bool
    
    @State var animateLike: Bool = false
    @State var addHeartAnimationToView: Bool = true
    @State var showActionSheet: Bool = false
    @State var actionSheetType: PostActionSheetOption = .general
    
    @State var postImage: UIImage = UIImage(named: "loadingImage")!
    @State var profileImage: UIImage = UIImage(named: "loadingImage")!
    
    @AppStorage(UserDefaultsFields.userId) var currentUserID: String?
    
    @State var showError: Bool = false
    @State var alertTitle: String = ""
    
    enum PostActionSheetOption {
        case general
        case report
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if showHeaderAndFooter {
                //MARK: Header
                HStack {
                    NavigationLink {
                        LazyView { ProfileView(displayName: postModel.username, profileUserId: postModel.userId, isMyProfile: false, posts: PostArrayObject(userID: postModel.userId)) }
                    } label: {
                        Image(uiImage: profileImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30, alignment: .center)
                            .cornerRadius(15)
                        Text(postModel.username)
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    Button {
                        showActionSheet.toggle()
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                }
                .padding(6)
            }
            
            //MARK: -Image
            ZStack {
                Image(uiImage: postImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: showHeaderAndFooter ? 300 : 90,
                           height: showHeaderAndFooter ? 300 : 90)
                    .onTapGesture(count: 2) {
                        if !postModel.likedByUser { likePost() }
                    }
                
                if addHeartAnimationToView {
                    LikeAnimationView(animate: $animateLike)
                }
            }
            
            if showHeaderAndFooter {
                //MARK: -Footer
                HStack(alignment: .center, spacing: 20) {
                    Button {
                        if postModel.likedByUser {
                            //unlike post
                            unlikePost()
                        } else {
                            //like post
                            likePost()
                        }
                    } label: {
                        Image(systemName: postModel.likedByUser ? "heart.fill" : "heart")
                            .font(.title3)
                    }
                    .accentColor(postModel.likedByUser ? .red : .primary)
                    
                    NavigationLink {
                        CommentsView(post: postModel)
                    } label: {
                        Image(systemName: "bubble.middle.bottom")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    
                    Button {
                        sharePost()
                    } label: {
                        Image(systemName: "paperplane")
                            .font(.title3)
                            .accentColor(.primary)
                    }

                    Spacer()
                }
                .padding(6)
                
                if let caption = postModel.caption {
                    HStack {
                        Text(caption)
                        Spacer(minLength: 0)
                    }
                    .padding(6)
                }
            }
        }
        .actionSheet(isPresented: $showActionSheet) { getActionSheet() }
        .onAppear {
            getImages()
        }
        .alert(isPresented: $showError) {
            Alert(title: Text(alertTitle))
        }
    }
    
    //MARK: -Functions
    func likePost() {
        let updatedPostModel = PostModel(postId: postModel.postId, userId: postModel.userId, username: postModel.username, caption: postModel.caption, date: postModel.date, noOfLikes: postModel.noOfLikes + 1, likedByUser: true)
        self.postModel = updatedPostModel
        
        animateLike = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            animateLike = false
        })
        
        //Update Database
        guard let currentUserID else {
            print("User Id missing while liking post!")
            alertTitle = "You have to be signed In to like/unlike a post🤬"
            showError.toggle()
            return
        }
        DataService.shared.likePost(postID: postModel.postId, currentUserID: currentUserID)
    }
    
    func unlikePost() {
        let updatedPostModel = PostModel(postId: postModel.postId, userId: postModel.userId, username: postModel.username, caption: postModel.caption, date: postModel.date, noOfLikes: postModel.noOfLikes - 1, likedByUser: false)
        self.postModel = updatedPostModel
        
        //Update Database
        guard let currentUserID else {
            print("User Id missing while unliking post!")
            showError.toggle()
            return
        }
        DataService.shared.unlikePost(postID: postModel.postId, currentUserID: currentUserID)
    }
    
    func getImages() {
        //Get Profile Image
        ImageManager.shared.downloadProfileImage(userID: postModel.userId) { self.profileImage = $0 ?? UIImage(systemName: "person")! }
        
        //Get Post Image
        ImageManager.shared.downloadPostImage(postID: postModel.postId, completion: { self.postImage = $0 ?? UIImage(named: "demoImage")! })
    }
    
    func getActionSheet() -> ActionSheet {
        switch self.actionSheetType {
        case .general:
            return ActionSheet(title: Text("What would you like to do?"), buttons: [
                .destructive(Text("Report"), action: {
                    self.actionSheetType = .report
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                        self.showActionSheet.toggle()
                    })
                }),
                .default(Text("Learn More..."), action: {
                    print("Learn More!")
                }),
                .cancel()
            ])
        case .report:
            return ActionSheet(title: Text("Why are you reporting this post?"), buttons: [
                .destructive(Text("This is inappropriate"), action: {
                    reportPost(reason: "This is inappropriate")
                }),
                .destructive(Text("This is spam"), action: {
                    reportPost(reason: "This is spam")
                }),
                .destructive(Text("It made me uncomfortable"), action: {
                    reportPost(reason: "It made me uncomfortable")
                }),
                .cancel({ self.actionSheetType = .general })
            ])
        }
    }
    
    func reportPost(reason: String) {
        DataService.shared.uploadReport(reason: reason, postID: postModel.postId) { success in
            if success {
                alertTitle = "Successfully placed the report😃"
                showError.toggle()
            }
        }
    }
    
    func sharePost() {
        //DEEPLINKS in actual app, but not that lengthy process.
        let message = "Check out this post in Flashgram!"
        let image = postImage
        let link = URL(string: "https://www.google.com")!
        let activityController = UIActivityViewController(activityItems: [ message, image, link], applicationActivities: nil)
        let viewController = UIApplication.shared.windows.first?.rootViewController
        viewController?.present(activityController, animated: true)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostView(postModel: PostModel(postId: "", userId: "", username: "abc", caption: "This is a test caption!", date: Date(), noOfLikes: 2, likedByUser: true), showHeaderAndFooter: true)
        }
    }
}
