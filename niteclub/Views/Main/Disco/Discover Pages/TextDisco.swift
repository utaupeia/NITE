//
//  TextDisco.swift
//  niteclub
//
//  Created by +++ on 10/22/23.
//

import SwiftUI

struct TextDisco: View {
    @EnvironmentObject var viewModel: PostsViewModel
<<<<<<< HEAD
    @State private var navigationPath = NavigationPath()
    @Namespace private var namespace
    @EnvironmentObject var sharedViewModel: SharedViewModel

    var body: some View {
        NavigationStack(path: $navigationPath) {
            
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    VStack {
                        ForEach(viewModel.textPostViewModels.indices, id: \.self) { index in
                            PostView(
                                viewModel: viewModel.textPostViewModels[index],
                                postsVM: viewModel, // new
                                navigationPath: $navigationPath,
                                namespace: namespace,
                                onSelectPost: { selectedViewModel in
                                    sharedViewModel.selectedPost = selectedViewModel
                                }
                            )
                            //                        , onSelect: { _ in selectedPostIndex = index }
                            .padding(.bottom, 8)
                        }
                    }
                    .onAppear {
                        //                    if let index = selectedPostIndex {
                        //                        scrollViewProxy.scrollTo(index)
                        //                    }
=======
    @Binding var navigationPath: NavigationPath
    @State private var selectedPostIndex: Int?

    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView {
                VStack {
                    ForEach(viewModel.textPostViewModels.indices, id: \.self) { index in
                        PostView(viewModel: viewModel.textPostViewModels[index],
                                 navigationPath: $navigationPath)
//                        , onSelect: { _ in selectedPostIndex = index }
                            .padding(.bottom, 8)
                    }
                }
                .onAppear {
                    if let index = selectedPostIndex {
                        scrollViewProxy.scrollTo(index)
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
                    }
                }
            }
            .padding(.horizontal, 6)
        }
    }
}

#Preview {
<<<<<<< HEAD
    TextDisco()
=======
    TextDisco( navigationPath: .constant(NavigationPath()))
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
        .environmentObject(PostsViewModel()) // Provide a PostsViewModel instance

}
