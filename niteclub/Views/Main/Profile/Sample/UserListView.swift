//
//  UserListView.swift
//  niteclub
//
//  Created by +++ on 12/13/23.
//

import SwiftUI
struct User1: Identifiable, Hashable {
    var id: UUID
    var username: String
}

class UserViewModel1: ObservableObject {
    @Published var user: User1?  // Current logged-in user
    @Published var viewingUser: User1?  // User being viewed in UserProfileView

    init(currentUser: User1? = nil) {
        self.user = currentUser
    }

    func setCurrentUser(_ newUser: User1) {
        self.user = newUser
    }

    func setViewingUser(_ newUser: User1) {
        self.viewingUser = newUser
    }
}

// Sample users for the list
let sampleUsers = [
    User1(id: UUID(), username: "Alice"),
    User1(id: UUID(), username: "Bob"),
    User1(id: UUID(), username: "Charlie")
]

struct UserListView: View {
    @State private var navigationPath = NavigationPath()

    var body: some View {
        Text("")
//        NavigationStack(path: $navigationPath) {
//            List(sampleUsers) { user in
//                NavigationLink(user.username, value: user)
//            }
//            .navigationDestination(for: User1.self) { selectedUser in
//                UserProfileView()
//                    .environmentObject(userViewModel)
//            }
//        }
    }
}


//#Preview {
//    UserListView()
//        .environmentObject(userViewModel1)
//
//}
