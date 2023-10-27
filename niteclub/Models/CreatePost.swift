//
//  CreatePost.swift
//  niteclub
//
//  Created by +++ on 10/20/23.
//

import Foundation
import Combine
import SwiftUI

struct CreatePostFormData {
    var textContent: String = ""
    var selectedImages: [UIImage] = []  // this could be URLs or identifiers if you're fetching images from the web
    var selectedVideos: [String] = []  // assuming videos are referenced by some identifier
}


//class PostFactory {
//    func createPost(author: User, content: String, type: PostType, imageContent: [String]? = nil, videoContent: [URL]? = nil, videoDuration: TimeInterval? = nil, caption: String? = nil) -> Post {
//        switch type {
//        case .text:
//            return TextPost(author: author, content: content, timestamp: Date(), caption: caption)
//        case .image:
//            guard let imageContent = imageContent else { fatalError("Image content is required for image post") }
//            return ImagePost(author: author, content: content, timestamp: Date(), imageContent: imageContent, caption: caption)
//        case .video:
//            guard let videoContent = videoContent, let videoDuration = videoDuration else { fatalError("Video content and duration are required for video post") }
//            return VideoPost(author: author, content: content, timestamp: Date(), videoContent: videoContent, videoDuration: videoDuration, caption: caption)
//        }
//    }
//}



