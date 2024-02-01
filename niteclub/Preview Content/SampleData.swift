//
//  SampleData.swift
//  niteclub
//
//  Created by +++ on 10/25/23.
//

import Foundation

struct SampleData {
    static func user(for id: UUID) -> User? {
        // Return the user with the given id
        let allUsers = [userJohn, userEmma, userRobert, userBuhle, userRickkw, userYannie]
        return allUsers.first { $0.id == id }
    }
    
    static var allUsers: [User] {
        let dynamicUsers = generateSampleUsers(count: 50) // Generate 50 sample users

        return [userJohn, userEmma, userRobert, userBuhle, userRickkw, userYannie] + dynamicUsers
    }
    
    static func generateSampleUsers(count: Int) -> [User] {
        (1...count).map { i in
            User(id: UUID(),
                 username: "user\(i)",
                 profilePicture: "image\(i)", // Assuming you have placeholder images
                 following: [],
                 followers: [],
                 lurking: Int.random(in: 1...10000),
                 status: .default,
                 acquiredThemes: [sampleTheme, sampleTheme1, sampleTheme2, sampleTheme3, sampleTheme4, sampleTheme5, sampleTheme6].shuffled(),
                 selectedTheme: sampleTheme,
                 dateJoined: Date(),
                 location: "Location \(i)",
                 likedPosts: [])
        }
    }


    // Users
<<<<<<< HEAD
    static let userJohn = User(id: UUID(), username: "johndeez", profilePicture: "image1", following: [], followers: [], lurking: 332, status: .default, acquiredThemes: [sampleTheme,sampleTheme1,sampleTheme2,sampleTheme3,sampleTheme4, sampleTheme5,sampleTheme6], selectedTheme: sampleTheme4, dateJoined: Date(), location: "USA")
    static let userEmma = User(id: UUID(), username: "emma", profilePicture: "image10", following: [], followers: [], lurking: 129, status: .default, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme2, dateJoined: Date(), location: "USA")
    static let userRobert = User(id: UUID(), username: "robertg", profilePicture: "image19", following: [], followers: [], lurking: 31, status: .default, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme3, dateJoined: Date(), location: "USA")
    static let userBuhle = User(id: UUID(), username: "buhle", profilePicture: "image42", following: [], followers: [], lurking: 209, status: .foreverMember, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme4, dateJoined: Date(), location: "nyc", likedPosts: [])
    static let userRickkw = User(id: UUID(), username: "rickkw", profilePicture: "image32", following: [], followers: [], lurking: 3299, status: .foreverMember, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme5, dateJoined: Date(), location: "nyc", likedPosts: [])
    static let userYannie = User(id: UUID(), username: "yannie", profilePicture: "image48", following: [], followers: [], lurking: 5928, status: .admin, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme6, dateJoined: Date(), location: "nyc", likedPosts: [])

    static let bobby = User(id: UUID(), username: "bobby", profilePicture: "image15", following: [], followers: [], lurking: 6715, status: .admin, acquiredThemes: [themeSample1, themeSample2, themeSample3, themeSample4, themeSample5], selectedTheme: sampleTheme6, dateJoined: Date(), location: "nyc", likedPosts: [])
    static let carrie = User(id: UUID(), username: "carrie", profilePicture: "image33", following: [], followers: [], lurking: 33789, status: .admin, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme6, dateJoined: Date(), location: "nyc", likedPosts: [])
    static let donna = User(id: UUID(), username: "donna", profilePicture: "image48", following: [], followers: [], lurking: 2317, status: .admin, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme6, dateJoined: Date(), location: "nyc", likedPosts: [])
    static let faye = User(id: UUID(), username: "faye", profilePicture: "image29", following: [], followers: [], lurking: 3421, status: .admin, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme6, dateJoined: Date(), location: "nyc", likedPosts: [])
    static let gilly = User(id: UUID(), username: "gilly", profilePicture: "image4", following: [], followers: [], lurking: 35253, status: .admin, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme6, dateJoined: Date(), location: "nyc", likedPosts: [])
    static let hhhether = User(id: UUID(), username: "hhhether", profilePicture: "image37", following: [], followers: [], lurking: 643, status: .admin, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme6, dateJoined: Date(), location: "nyc", likedPosts: [])
    static let ii_ii = User(id: UUID(), username: "ii_ii", profilePicture: "image16", following: [], followers: [], lurking: 5756, status: .admin, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme6, dateJoined: Date(), location: "nyc", likedPosts: [])
    static let jklmao = User(id: UUID(), username: "jklmao", profilePicture: "image22", following: [], followers: [], lurking: 65, status: .admin, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme6, dateJoined: Date(), location: "nyc", likedPosts: [])
    static let kola = User(id: UUID(), username: "kola", profilePicture: "image8", following: [], followers: [], lurking: 876, status: .admin, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme6, dateJoined: Date(), location: "nyc", likedPosts: [])
    static let lana = User(id: UUID(), username: "lana", profilePicture: "image28", following: [], followers: [], lurking: 217, status: .admin, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme6, dateJoined: Date(), location: "nyc", likedPosts: [])
    static let mosaic = User(id: UUID(), username: "mosaic", profilePicture: "image18", following: [], followers: [], lurking: 5313, status: .admin, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme6, dateJoined: Date(), location: "nyc", likedPosts: [])
    static let nefer00 = User(id: UUID(), username: "nefer00", profilePicture: "image38", following: [], followers: [], lurking: 8765, status: .admin, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme6, dateJoined: Date(), location: "nyc", likedPosts: [])
    static let mozart = User(id: UUID(), username: "mozart", profilePicture: "image32", following: [], followers: [], lurking: 531111, status: .admin, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme6, dateJoined: Date(), location: "nyc", likedPosts: [])
    static let ekkstacy = User(id: UUID(), username: "ii_ii", profilePicture: "image16", following: [], followers: [], lurking: 5756, status: .admin, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme6, dateJoined: Date(), location: "nyc", likedPosts: [])

=======
    static let userJohn = User(id: UUID(), username: "johndeez", profilePicture: "image1", following: [], followers: [], lurking: 7832, status: .default, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme, dateJoined: Date(), location: "USA")
    static let userEmma = User(id: UUID(), username: "emma", profilePicture: "image10", following: [], followers: [], lurking: 322, status: .default, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme, dateJoined: Date(), location: "USA")
    static let userRobert = User(id: UUID(), username: "robertg", profilePicture: "image19", following: [], followers: [], lurking: 4257, status: .default, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme, dateJoined: Date(), location: "USA")
    static let userBuhle = User(id: UUID(), username: "buhle", profilePicture: "image42", following: [], followers: [], lurking: 35988, status: .foreverMember, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme, dateJoined: Date(), location: "nyc", likedPosts: [])
    static let userRickkw = User(id: UUID(), username: "rickkw", profilePicture: "image32", following: [], followers: [], lurking: 5928, status: .foreverMember, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme, dateJoined: Date(), location: "nyc", likedPosts: [])
    static let userYannie = User(id: UUID(), username: "yannie", profilePicture: "image48", following: [], followers: [], lurking: 5928, status: .admin, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme, dateJoined: Date(), location: "nyc", likedPosts: [])
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee

    // ... as many users as you want for variety.
    
    // Themes
    static let sampleTheme1 = Theme(
        id: UUID(),
        name: "*_*",
        content: ThemeContent(id: UUID(), themeURL: "image29"), // Placeholder URL
        price: 1.99,
        creationDate: Date(),
        creator: userEmma.id, // Assuming userJohn is the creator
        approved: true
    )

    static let sampleTheme2 = Theme(
        id: UUID(),
        name: "--&--",
        content: ThemeContent(id: UUID(), themeURL: "image37"), // Placeholder URL
        price: 2.99,
        creationDate: Date(),
        approved: true
    )
    
    static let sampleTheme3 = Theme(
        id: UUID(),
        name: "#theme@",
        content: ThemeContent(id: UUID(), themeURL: "image38"), // Placeholder URL
        price: 1.99,
        creationDate: Date(),
        approved: true
    )

    static let sampleTheme4 = Theme(
        id: UUID(),
        name: "(yuhhh)",
        content: ThemeContent(id: UUID(), themeURL: "image39"), // Placeholder URL
        price: 2.99,
        creationDate: Date(),
        approved: true
    )

    static let sampleTheme5 = Theme(
        id: UUID(),
        name: "^shi",
        content: ThemeContent(id: UUID(), themeURL: "image40"), // Placeholder URL
        price: 1.99,
        creationDate: Date(),
        approved: true
    )

    static let sampleTheme6 = Theme(
        id: UUID(),
        name: "wt:tf",
        content: ThemeContent(id: UUID(), themeURL: "image41"), // Placeholder URL
        price: 2.99,
        creationDate: Date(),
        approved: true
    )


}

// Continuing in SampleData.swift

extension SampleData {
    // Posts by John
<<<<<<< HEAD
    static let johnTextPost = Post(id: UUID(), author: userJohn, timestamp: Date(), textContent: "John's amazing text post!", images: nil, videos: nil, socialInteractions: SocialInteractionsManager(
        comments: [],
        likes: [SampleData.userEmma, SampleData.userRobert], // Predefined likes
        reposts: [SampleData.faye, SampleData.donna, SampleData.userEmma, SampleData.userRobert,SampleData.carrie],
        quotes: []
))
=======
    static let johnTextPost = Post(id: UUID(), author: userJohn, timestamp: Date(), textContent: "John's amazing text post!", images: nil, videos: nil, socialInteractions: SocialInteractionsManager())
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
    static let johnImagePost = Post(id: UUID(), author: userJohn, timestamp: Date(), textContent: "where is this caption", images: ["image32"], videos: nil, socialInteractions: SocialInteractionsManager())
    static let johnImagePost2 = Post(id: UUID(), author: userJohn, timestamp: Date(), textContent: "testing the three image look", images: ["image6", "image5", "image1"], videos: nil, socialInteractions: SocialInteractionsManager())

    // ...

    // Posts by Emma
    static let emmaVideoPost = Post(id: UUID(), author: userEmma, timestamp: Date(), textContent: "Emma's vacation!", images: ["image18"], videos: nil, socialInteractions: SocialInteractionsManager())
<<<<<<< HEAD
    static let emmaImagePost = Post(id: UUID(), author: userEmma, timestamp: Date(), textContent: "look at my pics!", images: ["image7", "image3"], videos: nil, socialInteractions: SocialInteractionsManager(
        comments: [
            Comment(author: SampleData.donna, text: "mid ass post!", timestamp: Date()),
            Comment(author: SampleData.faye, text: "nothing really to say here", timestamp: Date()),
            Comment(author: SampleData.carrie, text: "this post is so ass actually  i do not fuck with it at all", timestamp: Date()),
            Comment(author: SampleData.kola, text: "suspect at best", timestamp: Date()),
            Comment(author: SampleData.lana, text: ":)", timestamp: Date())
        ],
        likes: [SampleData.donna, SampleData.userEmma, SampleData.userRobert,SampleData.carrie], // Predefined likes
        reposts: [SampleData.faye, SampleData.donna, SampleData.userEmma, SampleData.userRobert,SampleData.carrie],
        quotes: []))
=======
    static let emmaImagePost = Post(id: UUID(), author: userEmma, timestamp: Date(), textContent: "look at my pics!", images: ["image7", "image3"], videos: nil, socialInteractions: SocialInteractionsManager())
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee

    // ...

    // Posts by Robert
    static let robertTextPost = Post(id: UUID(), author: userRobert, timestamp: Date(), textContent: "Robert's thoughts on SwiftUI", images: nil, videos: nil, socialInteractions: SocialInteractionsManager())
    
    static let robertImagePost = Post(id: UUID(), author: userRobert, timestamp: Date(), textContent: "ummm image", images: ["image23", "image8", "image6", "image2"], videos: nil, socialInteractions: SocialInteractionsManager())

    // ...
    
    // Posts By Buhlee
    static let text0 = Post(id: UUID(), author: userBuhle, timestamp: Date(), textContent: "making ssample posts is harder than ionce previously believed i hope noone reads this shit", images: nil, videos: nil, socialInteractions: SocialInteractionsManager())
    static let text1 = Post(id: UUID(), author: userBuhle, timestamp: Date(), textContent: "what ima say here reaelly it could be something very deep and long thought out about how this app needs to fuckin work but idk", images: nil, videos: nil, socialInteractions: SocialInteractionsManager())
    static let text2 = Post(id: UUID(), author: userBuhle, timestamp: Date(), textContent: "more to say more to say but really i wanna shut the hell up ", images: nil, videos: nil, socialInteractions: SocialInteractionsManager())
    static let text3 = Post(id: UUID(), author: userBuhle, timestamp: Date(), textContent: "like 10 more samoles to go", images: nil, videos: nil, socialInteractions: SocialInteractionsManager())
    static let text4 = Post(id: UUID(), author: userBuhle, timestamp: Date(), textContent: "pleqase god make the sample posts appear out of thin air so i dont have to write more", images: nil, videos: nil, socialInteractions: SocialInteractionsManager())
    static let text5 = Post(id: UUID(), author: userBuhle, timestamp: Date(), textContent: "im loving this long thought process maybe this really will be the best sample post ever written in the history of sample posts , we will see", images: nil, videos: nil, socialInteractions: SocialInteractionsManager())
    static let text6 = Post(id: UUID(), author: userBuhle, timestamp: Date(), textContent: "done here with these ones", images: nil, videos: nil, socialInteractions: SocialInteractionsManager())
    
    static let image1 = Post(id: UUID(), author: userBuhle, timestamp: Date(), textContent: "image posts as well can have very long context to them to add some spice to the situation so we have to mock out if the design of this is adequate enough to ship", images: ["image41", "image28", "image36", "image22"], videos: nil, socialInteractions: SocialInteractionsManager())
    
    static let image2 = Post(id: UUID(), author: userBuhle, timestamp: Date(), textContent: "", images: ["image34", "image38"], videos: nil, socialInteractions: SocialInteractionsManager())
    static let image3 = Post(id: UUID(), author: userBuhle, timestamp: Date(), textContent: "short words with long thoughts ", images: ["image20", "image28"], videos: nil, socialInteractions: SocialInteractionsManager())
    static let image4 = Post(id: UUID(), author: userBuhle, timestamp: Date(), textContent: "insert drake lyrics for all the bbl baddies ", images: ["image39", "image21", "image35"], videos: nil, socialInteractions: SocialInteractionsManager())

    // other posts
    static let text10 = Post(id: UUID(), author: userRickkw, timestamp: Date(), textContent: "more words to say and its getting wild ", images: nil, videos: nil, socialInteractions: SocialInteractionsManager())
    static let text11 = Post(id: UUID(), author: userRickkw, timestamp: Date(), textContent: "need more image posts for my array", images: nil, videos: nil, socialInteractions: SocialInteractionsManager())
    static let text12 = Post(id: UUID(), author: userRickkw, timestamp: Date(), textContent: "lord have...", images: nil, videos: nil, socialInteractions: SocialInteractionsManager())

    static let image11 = Post(id: UUID(), author: userRickkw, timestamp: Date(), textContent: "image posts as well can have very long context to them to add some spice to the situation so we have to mock out if the design of this is adequate enough to ship", images: [ "image43", "image20"], videos: nil, socialInteractions: SocialInteractionsManager())
    static let image12 = Post(id: UUID(), author: userRickkw, timestamp: Date(), textContent: "", images: ["image29", "image38"], videos: nil, socialInteractions: SocialInteractionsManager())
    static let image13 = Post(id: UUID(), author: userRickkw, timestamp: Date(), textContent: "short words with long thoughts ", images: ["image28"], videos: nil, socialInteractions: SocialInteractionsManager())
    static let image41 = Post(id: UUID(), author: userRickkw, timestamp: Date(), textContent: "insert + baddies ", images: ["image19"], videos: nil, socialInteractions: SocialInteractionsManager())
    static let image42 = Post(id: UUID(), author: userRickkw, timestamp: Date(), textContent: " ", images: ["image27"], videos: nil, socialInteractions: SocialInteractionsManager())
    static let image43 = Post(id: UUID(), author: userRickkw, timestamp: Date(), textContent: "es", images: ["image30"], videos: nil, socialInteractions: SocialInteractionsManager())
    static let image44 = Post(id: UUID(), author: userRickkw, timestamp: Date(), textContent: "what the hell  ", images: ["image24"], videos: nil, socialInteractions: SocialInteractionsManager())
    static let image45 = Post(id: UUID(), author: userRickkw, timestamp: Date(), textContent: "so many baddies ", images: ["image17"], videos: nil, socialInteractions: SocialInteractionsManager())
    static let image46 = Post(id: UUID(), author: userRickkw, timestamp: Date(), textContent: "insert drake lyrics for all the bbl baddies ", images: ["image33"], videos: nil, socialInteractions: SocialInteractionsManager())
    static let johnImagePost23 = Post(id: UUID(), author: userJohn, timestamp: Date(), textContent: "where is this caption", images: ["image32"], videos: nil, socialInteractions: SocialInteractionsManager())

    static let yanniepost = Post(id: UUID(), author: userYannie, timestamp: Date(), textContent: "im yannie hello hi", images: ["image44" , "image46", "image47"], videos: nil, socialInteractions: SocialInteractionsManager())
<<<<<<< HEAD
    
    static let vidPost0 = Post(id: UUID(), author: userYannie, timestamp: Date(), textContent: "im yannie hello hi", images: nil,         videos: [Bundle.main.url(forResource: "samplevideo", withExtension: "mov")?.absoluteString ?? ""],
 socialInteractions: SocialInteractionsManager())

    static let vidPost1 = Post(id: UUID(), author: userYannie, timestamp: Date(), textContent: "im yannie hello hi", images: nil,         videos: [Bundle.main.url(forResource: "vid1", withExtension: "mov")?.absoluteString ?? ""],
 socialInteractions: SocialInteractionsManager(
    likes: [SampleData.faye, SampleData.donna, SampleData.userEmma, SampleData.userRobert,SampleData.carrie], // Predefined likes
    reposts: [SampleData.faye, SampleData.donna, SampleData.userEmma, SampleData.userRobert,SampleData.carrie],
    quotes: []

 ))

    static let vidPost2 = Post(id: UUID(), author: userEmma, timestamp: Date(), textContent: "im yannie hello hi", images: nil,         videos: [Bundle.main.url(forResource: "vid2", withExtension: "mov")?.absoluteString ?? ""],
 socialInteractions: SocialInteractionsManager())
    
    static let vidPost3 = Post(id: UUID(), author: userJohn, timestamp: Date(), textContent: "im yannie hello hi", images: nil,         videos: [Bundle.main.url(forResource: "vid3", withExtension: "mov")?.absoluteString ?? ""],
 socialInteractions: SocialInteractionsManager(
    likes: [SampleData.faye, SampleData.donna, SampleData.userEmma, SampleData.userRobert,SampleData.carrie], // Predefined likes
    reposts: [],
    quotes: []
 ))

    static let vidPost4 = Post(id: UUID(), author: userJohn, timestamp: Date(), textContent: "im yannie hello hi", images: nil,        videos: [Bundle.main.url(forResource: "vid4", withExtension: "mov")?.absoluteString ?? ""],
 socialInteractions: SocialInteractionsManager())


    static let vidPost5 = Post(id: UUID(), author: userBuhle, timestamp: Date(), textContent: "im yannie hello hi", images: nil,         videos: [Bundle.main.url(forResource: "vid5", withExtension: "mov")?.absoluteString ?? ""],
 socialInteractions: SocialInteractionsManager())

    static let vidPost6 = Post(id: UUID(), author: userRickkw, timestamp: Date(), textContent: "im yannie hello hi", images: nil,         videos: [Bundle.main.url(forResource: "vid6", withExtension: "mov")?.absoluteString ?? ""],
 socialInteractions: SocialInteractionsManager())

    // Gather them for easy access and use
    static let allPosts: [Post] = [yanniepost,text0, image46, image44, johnTextPost, image42, johnImagePost,image1,image11, image12, image2, image3, emmaVideoPost, robertTextPost, image4, image45, emmaImagePost, robertImagePost, johnImagePost2, text1, text12, text2, text11, text3, text4, text5, text6, text10, vidPost0, vidPost1, vidPost2, vidPost3, vidPost4, vidPost5, vidPost6].shuffled() // Add all the posts here vidPost0, vidPost1, vidPost2, vidPost3, vidPost4, vidPost5, vidPost6
    
    
//     StoryPost Variables :
//        let id: UUID
//        let author: User
//        let media: StoryType
//        var imageUrl: String? // URL or name of the image
//        var videoUrl: String? // URL of the video
//        var duration: TimeInterval // For images, default 6 seconds
//        let timePosted: Date
//        var viewed: [User] // Users who viewed the post
//        var likes: [User] // Users who liked the post
//        var replies: [Reply] // Replies to the post
//        var isCloseFriendPost: Bool

    // Arrays of StoryPosts for each user
    static let johnStoryPosts = [
        StoryPost(author: userJohn, media: .image, imageUrl: "image31", duration: 6, timePosted: Date(), isCloseFriendPost: false),
        StoryPost(author: userJohn, media: .image, imageUrl: "image40", duration: 6, timePosted: Date(), isCloseFriendPost: false)
        // Add more story posts as needed
    ]

    static let emmaStoryPosts = [
        StoryPost(author: userEmma, media: .image, imageUrl: "image10", duration: 6, timePosted: Date(), isCloseFriendPost: false)
        // Add more story posts as needed
    ]

    static let rickStoryPosts = [
        StoryPost(author: userRickkw, media: .image, imageUrl: "image12", duration: 6, timePosted: Date(), isCloseFriendPost: false),
        StoryPost(author: userRickkw, media: .image, imageUrl: "image29", duration: 6, timePosted: Date(), isCloseFriendPost: false),
        StoryPost(author: userRickkw, media: .image, imageUrl: "image19", duration: 6, timePosted: Date(), isCloseFriendPost: false),
        StoryPost(author: userRickkw, media: .image, imageUrl: "image21", duration: 6, timePosted: Date(), isCloseFriendPost: false)
        // Add more story posts as needed
    ]


    // ... repeat for each user ...
    static let mfstory =     
    StoryPost(author: userEmma, media: .image, imageUrl: "image10", duration: 6, timePosted: Date(), isCloseFriendPost: false)

    static let johnStories = Story(author: userJohn, storyPosts: johnStoryPosts)
    static let emmaStories = Story(author: userEmma, storyPosts: emmaStoryPosts)
    static let rickStories = Story(author: userRickkw, storyPosts: rickStoryPosts)

    static let sampleStories: [Story] = [johnStories, emmaStories, rickStories]

=======

    // Gather them for easy access and use
    static let allPosts: [Post] = [yanniepost,text0, image46, image44, johnTextPost, image42, johnImagePost,image1,image11, image12, image2, image3, emmaVideoPost, robertTextPost, image4, image45, emmaImagePost, robertImagePost, johnImagePost2, text1, text12, text2, text11, text3, text4, text5, text6, text10].shuffled() // Add all the posts here
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
}
