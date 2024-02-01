//
//  ThemeSelectionView.swift
//  niteclub
//
//  Created by +++ on 1/26/24.
//

import SwiftUI

struct ThemeSelectionView: View {
    @StateObject var viewModel: UserViewModel
    @Namespace private var namespace
    @State private var selectedThemeIndex: Int = 0
    @State private var isExpanded: Bool = false
    @State private var expandTask: DispatchWorkItem?

    var body: some View {
        ZStack {
            VStack {
                if let acquiredThemes = viewModel.user?.acquiredThemes, !acquiredThemes.isEmpty {
                    TabView(selection: $selectedThemeIndex) {
                        ForEach(acquiredThemes.indices, id: \.self) { index in
                            ZStack(alignment:.bottomLeading) {
                                Image(acquiredThemes[index].content.themeURL)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 330 )
                                    .frame(height: isExpanded ? 500 : 150)
                                    .cornerRadius(24)
                                    .tag(index)
                                    .padding(12)
                                    .gesture(isExpanded ?  nil : DragGesture())
                                    .background(                                                RoundedRectangle(cornerRadius: 36)
                                        .stroke(selectedThemeIndex == index ?
                                            .blue : .white.opacity(0.0),
                                                lineWidth: 1.5)
                                )
                                HStack {
                                    Text("\(acquiredThemes[index].name ?? "")")
                                        .foregroundStyle(.white)
                                        .fontDesign(.monospaced)
                                        .font(.system(size: 14))
                                    
                                    RoundedRectangle(cornerRadius: 24)
                                        .frame(width: 15, height: 1.5)
                                        .foregroundStyle(.white)
                                    if let creatorId = acquiredThemes[index].creator,
                                       let creator = viewModel.allUsers.first(where: { $0.id == creatorId }) {
                                        Text("\(creator.username)")
                                            .foregroundColor(.white)
                                            .font(.system(size: 14))
                                            .bold()
                                    }
                                }.padding(24)
                            }
                        }
                    }
                    .frame(height: isExpanded ? 500+30 : 150+30)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isExpanded.toggle()
                            if !isExpanded, let acquiredThemes = viewModel.user?.acquiredThemes, selectedThemeIndex < acquiredThemes.count {
                                let selectedTheme = acquiredThemes[selectedThemeIndex]
                                viewModel.changeTheme(to: selectedTheme)
                            }
                        }
                        resetAutoSelectTimer()
                    }

                    .onChange(of: selectedThemeIndex) { _, _ in
                        resetAutoSelectTimer()
                        if let acquiredThemes = viewModel.user?.acquiredThemes, selectedThemeIndex < acquiredThemes.count {
                            let selectedTheme = acquiredThemes[selectedThemeIndex]
                            viewModel.changeTheme(to: selectedTheme)
                        }
                    }

                }
                if isExpanded {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 12))

                        Text("select your theme".uppercased())
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12))

                    }
                    .foregroundStyle(.white)
                    .fontDesign(.monospaced)
                    .opacity(0.75)
                

                }
            }
            // name of theme
            // name of creator
        }
    }
    
    private func resetAutoSelectTimer() {
        expandTask?.cancel()
        if isExpanded {
            let task = DispatchWorkItem {
                withAnimation {
                    self.isExpanded = false
                    applySelectedTheme()
                    
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: task)
            expandTask = task
        }
    }
    
    private func applySelectedTheme() {
        if let acquiredThemes = viewModel.user?.acquiredThemes, selectedThemeIndex < acquiredThemes.count {
            let selectedTheme = acquiredThemes[selectedThemeIndex]
            viewModel.changeTheme(to: selectedTheme)
        }
    }
}

struct ThemeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        // Mock ViewModel and User for the preview
        let mockViewModel = UserViewModel(user: SampleData.bobby)

        ThemeSelectionView(viewModel: mockViewModel)
    }
}

let themeSample1 = Theme(name: "sexytheme", content: sampleContent1, price: 0.0, creationDate: Date(), creator: SampleData.userEmma.id)
let themeSample2 = Theme(name: "otherting", content: sampleContent2, price: 0.0, creationDate: Date(), creator: SampleData.userEmma.id)
let themeSample3 = Theme(name: "theme3", content: sampleContent3, price: 0.0, creationDate: Date(),creator: SampleData.faye.id)
let themeSample4 = Theme(name: "theme4", content: sampleContent4, price: 0.0, creationDate: Date(),creator: SampleData.ekkstacy.id)
let themeSample5 = Theme(name: "theme5", content: sampleContent5, price: 0.0, creationDate: Date(),creator: SampleData.carrie.id)


let sampleContent1 = ThemeContent(id: UUID(), themeURL: "image8")
let sampleContent2 = ThemeContent(id: UUID(), themeURL: "image18")
let sampleContent3 = ThemeContent(id: UUID(), themeURL: "image28")
let sampleContent4 = ThemeContent(id: UUID(), themeURL: "image38")
let sampleContent5 = ThemeContent(id: UUID(), themeURL: "image20")
