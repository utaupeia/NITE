//
//  ProfileVideoContentView.swift
//  niteclub
//
//  Created by +++ on 11/2/23.
//

import SwiftUI

struct ProfileVideoContentView: View {
    var user: User

    var allVideoPosts: [PostViewModel] // This should be all image posts, passed from outside or fetched inside the view.

    // Filter to only include image posts belonging to the specified user
    var userSpecificImagePosts: [PostViewModel] {
        allVideoPosts.filter { $0.post.author.id == user.id && $0.post.videos != nil }
    }

       let columns: [GridItem] = [
           GridItem(.flexible(),spacing: nil, alignment: nil),
       ]
       
       var body: some View {
           
           ScrollView(showsIndicators: false) {
                   LazyVGrid(columns: columns) {
                                   ForEach(0..<20) { index in
                                       Blur(style: .dark)
                                           .frame(width: .infinity)
                                           .frame(height: 200)
                                           .cornerRadius(24)
//                                       LandscapeVideoPostView()
                       }
                   }
               
               .padding(.top, 30)
           }
           .padding(.horizontal, 6)
       }
   }

//
//#Preview {
//    ProfileVideoContentView(user: sampleUser)
//}

struct ProfileVideoContentView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleUser = SampleData.userRickkw

        let videoPosts = SampleData.allPosts.filter { post in
            post.author.id == sampleUser.id && !(post.videos?.isEmpty ?? true)
        }.map { post in
            PostViewModel(post: post, currentUser: sampleUser)
        }

        ProfileVideoContentView(user: sampleUser, allVideoPosts: videoPosts)
    }
}

