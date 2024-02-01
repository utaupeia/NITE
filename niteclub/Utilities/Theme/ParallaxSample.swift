//
//  ParallaxSample.swift
//  niteclub
//
//  Created by +++ on 1/27/24.
//

import SwiftUI

struct ParallaxSample: View {
    /// view properties
    @StateObject var viewModel: UserViewModel
    @State private var centeredIndex: Int?
    @State private var scrollToIndex: Int = 0

    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                Button("Scroll to Index") {
                    withAnimation {
                        proxy.scrollTo(scrollToIndex, anchor: .center)
                    }
                }

                ScrollView(.vertical) {
                    VStack(spacing: 15) {
                        
                        if let acquiredThemes = viewModel.user?.acquiredThemes, !acquiredThemes.isEmpty {

                        GeometryReader(content: { geometry in
                            let size = geometry.size
                            
                            ScrollView(.horizontal) {
                                HStack(spacing: 15) {
                                    ForEach(acquiredThemes.indices, id: \.self) { index in
                                        
                                        GeometryReader(content: { innerGeometry in
// proxy in
//                                            let cardSize = proxy.size
                                            let cardSize = innerGeometry.size
                                            
                                            Image(acquiredThemes[index].content.themeURL)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: cardSize.width, height: cardSize.height)
                                                .clipShape(.rect(cornerRadius: 15))
                                                .shadow(color:.black.opacity(0.25) ,radius: 8, x: 5, y: 10)
                                        })
                                        .frame(width: size.width - 60, height: size.height - 50)
                                        .id(index)
                                        .border(.red)
                                        // scroll animation
                                        .scrollTransition(.interactive, axis: .horizontal) {
                                            view, phase in
                                            view.scaleEffect(phase.isIdentity ? 1 : 1)
                                        }
                                    }
                                }
                                .padding(.horizontal, 30)
                                .scrollTargetLayout() // ios17
                                .frame(height: size.height, alignment: .top)
                            }
                            .scrollTargetBehavior(.viewAligned)
                            .scrollIndicators(.hidden)
                        })
                        .frame(height: 500)
                        .padding(.horizontal, -15)
                        .padding(.top, 10)
                    }
                    }
                    .padding(15)
                }
                .onChange(of: centeredIndex) { newIndex, _ in
                    if let unwrappedIndex = newIndex {
                        print("Centered Item: \(unwrappedIndex)")
                    } else {
                        print("Centered Item: nil")
                    }
            }
            }
        }

    }
    private func isItemCentered(outerGeometry: GeometryProxy, innerGeometry: GeometryProxy) -> Bool {
        let itemMidPoint = innerGeometry.frame(in: .global).midX
        let screenMidPoint = outerGeometry.size.width / 2
        return abs(itemMidPoint - screenMidPoint) < 20 // Adjust this threshold as needed
    }

}

//#Preview {
//    ParallaxSample()
//}

struct ParallaxSample_Previews: PreviewProvider {
    static var previews: some View {
        // Mock ViewModel and User for the preview
        let mockViewModel = UserViewModel(user: SampleData.bobby)

        ParallaxSample(viewModel: mockViewModel)
    }
}
