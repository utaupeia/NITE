//
//  TextDisco.swift
//  niteclub
//
//  Created by +++ on 10/22/23.
//

import SwiftUI

struct TextDisco: View {
    @EnvironmentObject var viewModel: PostsViewModel
    @Binding var navigationPath: NavigationPath
    @Namespace private var namespace
    @EnvironmentObject var sharedViewModel: SharedViewModel

    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView {
                VStack {
                    ForEach(viewModel.textPostViewModels.indices, id: \.self) { index in
                        PostView(
                            viewModel: viewModel.textPostViewModels[index],
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
                }
            }
        }
        .padding(.horizontal, 6)
    }
}

#Preview {
    TextDisco( navigationPath: .constant(NavigationPath()))
        .environmentObject(PostsViewModel()) // Provide a PostsViewModel instance

}
