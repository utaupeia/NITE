//
//  CreatePostViewModel.swift
//  niteclub
//
//  Created by +++ on 10/26/23.
//

import Foundation

class CreatePostViewModel: ObservableObject {
    var currentUser: User // This represents the currently logged-in user

    // 1. Properties for post content.
    @Published var textContent: String = ""
    @Published var images: [String] = [] // Placeholder for image data. You might use UIImage or some other data type in a real-world scenario.
    @Published var videos: [String] = [] // Placeholder for video data. Similarly, you might use a different data type in reality.
    @Published var isNSFW: Bool = false {
        didSet {
            if isNSFW {
                isCloseFriends = false
            }
        }
    }

    @Published var isCloseFriends: Bool = false {
        didSet {
            if isCloseFriends {
                isNSFW = false
            }
        }
    }
    
    
    var textCharacterLimit: Int {
        return currentUser.status == .default ? 222 : 444
    }

    var textInputProgress: CGFloat {
        return CGFloat(textContent.count) / CGFloat(textCharacterLimit)
    }


    init(currentUser: User, textContent: String = "", images: [String] = [], videos: [String] = []) {
        self.currentUser = currentUser
        self.textContent = textContent
        self.images = images
        self.videos = videos
    }

    func canAddImage() -> Bool {
        switch currentUser.status {
        case .default:
            return images.isEmpty && videos.isEmpty // Allow 1 image only if no videos are present
        default:
            return images.count < 4 && videos.isEmpty // Allow up to 4 images only if no videos are present
        }
    }

    func canAddVideo() -> Bool {
        switch currentUser.status {
        case .default:
            return false // Default users can't add videos
        default:
            return images.isEmpty && videos.isEmpty // Allow 1 video only if no images are present
        }
    }

    // 2. Methods to add images, videos.
    func addImage(_ image: String) {
        if canAddImage() {
            images.append(image)
        }
        // Handle the scenario when the user can't add more images (e.g., show an alert)
    }
    
    func addVideo(_ video: String) {
        if canAddVideo() {
            videos.append(video)
        }
        // Handle the scenario when the user can't add a video (e.g., show an alert)
    }


    // 3. Method to create a post.
    func createPost(author: User, timestamp: Date = Date()) -> Post {
        let interactionsManager = SocialInteractionsManager()
        let newPost = Post(author: author, timestamp: timestamp, textContent: textContent, images: images, videos: videos, socialInteractions: interactionsManager, isCloseFriends: isCloseFriends, isNSFW: isNSFW)
        return newPost
    }
    
    func clearContent() {
        textContent = ""
        // Reset other properties as needed
    }
    func updateTextContent(newText: String) {
        textContent = String(newText.prefix(textCharacterLimit))
    }


    func validateForPostCreation() -> Bool {
        // Add validation logic (e.g., check if textContent is empty)
        return true // Return true if validation passes
    }


}



