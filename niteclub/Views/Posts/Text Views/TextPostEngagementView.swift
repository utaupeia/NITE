//
//  TextPostEngagementView.swift
//  niteclub
//
//  Created by +++ on 11/11/23.
//

import SwiftUI

struct TextPostEngagementView: View {
    let post: Post
    
    @Binding var isExpanded: Bool
//    var namespace: Namespace.ID

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    
    TextPostEngagementView(post: samplePost, isExpanded: .constant(true)
//                           , namespace: namespace
    )
}
