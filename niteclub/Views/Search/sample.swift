//
//  sample.swift
//  niteclub
//
//  Created by +++ on 12/7/23.
//

import SwiftUI

class UsersViewModel: ObservableObject {
    @Published var users: [User] = SampleData.allUsers
    // Rest of the ViewModel code...
}

struct sample: View {
    @ObservedObject var usersViewModel: UsersViewModel // ViewModel holding an array of User objects
    @State private var navigationPath = NavigationPath()
    @EnvironmentObject var postsVM: PostsViewModel

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                VStack {
                    ForEach(usersViewModel.users) { user in
                        UserCard(viewModel: UserViewModel(), dateToDisplay: user.dateJoined, navigationPath: $navigationPath, onTap: {})
                    }
                }
            }
            .navigationDestination(for: User.self) { user in
                ProfileContentTabView(user: user, navigationPath: $navigationPath)
                    .environmentObject(UserViewModel())
                    .environmentObject(PostsViewModel())
                    .environmentObject(postsVM.userViewModel)

            }
        }
    }
}


//#Preview {
//    sample(usersViewModel: usersViewModel )
//}

struct sample_Previews: PreviewProvider {
    static var previews: some View {
        let usersViewModel = UsersViewModel() // Initialize with sample data if needed
        sample(usersViewModel: usersViewModel)
    }
}
