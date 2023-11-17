//
//  ThemeDisco.swift
//  niteclub
//
//  Created by +++ on 10/25/23.
//

import SwiftUI

struct ThemeDisco: View {
    @Namespace private var animation
    @State private var isExpanded = false
    let themes = [ "image30", "image32", "image36" , "image24", "image35" ,"image26", "image7","image8","image9","image10"]
    @State private var selectedTab: Int = 0
    
    func scaleValue(globalFrame: CGRect, frame: CGRect) -> CGFloat {
        let value = frame.midX - globalFrame.midX
        let scale = 1 - (abs(value) / UIScreen.main.bounds.width)
        return scale < 0.88 ? 0.88 : scale
    }
    @State private var prePurchase = false
    @State private var Purchase = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
                if isExpanded {
                    expandedTheme
            
                } else {
                    smallTheme
                    
                }
        }
    }
    
    var smallTheme: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                ForEach(themes.indices, id: \.self) { index in
                    ZStack {
                        Image(themes[index])
                            .resizable()
                            .matchedGeometryEffect(id: themes[index], in: animation)
                            .aspectRatio(contentMode: .fill)
                        Blur(style: .dark)
                            .opacity(0.9)
                    }
                            .frame(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.height / 1.6)
                            .cornerRadius(30)
                            .scaleEffect(selectedTab == index ? 1.1 : 1.0)
    //                        .animation(.spring(), value: selectedTab)
                            .tag(index)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedTab = index
                                    isExpanded = true
                                }
                            }
                        .offset(y: prePurchase ? -240 : -60 )
                    
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .ignoresSafeArea()

            HStack {
                Spacer()
//                VStack(alignment: .trailing) {
//                    Image("image2")
//                        .resizable()
//                        .frame(width: 36, height: 60)
//                        .cornerRadius(6)
//                    Text("NAME")
//                        .foregroundColor(.white)
//                        .fontWeight(.bold)
//                    Spacer()
//                }
//                .padding(.horizontal)
            }
                    VStack {
                        Spacer()
            
                        Button(action: {
                                    withAnimation(.spring()) {
                                        Purchase.toggle()
                                    }
                                }) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.green)
                                        .background(
                                        Circle()
                                            .frame(width: 60, height: 60)
                                            .foregroundColor( .white)
                                        )
                                        .frame(width: 40,height: 40)
                                }
                                .padding()
                            .padding()
            
                        if !prePurchase {
                            Spacer()
                        }
                    }
                    .frame(height: 300)
                    .opacity(prePurchase ? 1.0 : 0.0)
                    VStack {
                        Spacer()
            
                        HStack {
                            
                            VStack(alignment: .leading) {
                                Text("ThemeName")
                                    .matchedGeometryEffect(id: "name", in: animation)
                                    .foregroundColor(.white)
//                                Text("Time Remaining")
//                                    .matchedGeometryEffect(id: "time", in: animation)
//                                    .foregroundColor(.white)
                                Text("$0.99")
                                    .matchedGeometryEffect(id: "price", in: animation)
                                    .foregroundColor(.white)
                            }
                            .padding()
            
                                Spacer()
            
                                Button(action: {
                                    withAnimation(.spring()) {
                                        prePurchase.toggle()
                                    }
                                }) {
                                    Text(prePurchase ? "X": "$")
                                        .foregroundColor(.white)
                                        .background(
                                        Circle()
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(prePurchase ? .red : .green)
                                        )
                                        .frame(width: 40,height: 40)
                                }
                                .padding()
                                .padding()
                        }
                    }
            
                }
            }
    
    var expandedTheme: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                ForEach(themes.indices, id: \.self) { index in
                    Image(themes[index])
                        .resizable()
                        .matchedGeometryEffect(id: themes[index], in: animation)
                        .tag(index)
                        .scaledToFill()
                        .clipped()
                        .ignoresSafeArea()
                }
            }
            .cornerRadius(45)
            .ignoresSafeArea()
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            VStack {
                HStack(alignment: .top) {
                    Button(action: {
                        withAnimation(.spring()) {
                            isExpanded = false
                        }
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .background(
                                Blur(style: .dark)
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(20)
                                    .foregroundColor(.green)
                            )
                            .frame(width: 40,height: 40)
                    }
                    .padding()
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("ThemeName")
                            .matchedGeometryEffect(id: "name", in: animation)
                            .foregroundColor(.white)
                        Text("Time Remaining")
                            .matchedGeometryEffect(id: "time", in: animation)
                            .foregroundColor(.white)
                        Text("$0.99")
                            .matchedGeometryEffect(id: "price", in: animation)
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        Image("image2")
                            .resizable()
                            .frame(width: 36, height: 60)
                            .cornerRadius(6)
                        Text("NAME")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.spring()) {
                            prePurchase.toggle()
                        }
                    }) {
                        Text(prePurchase ? "X": "$")
                            .foregroundColor(.white)
                            .background(
                                Circle()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(prePurchase ? .red : .green)
                            )
                            .frame(width: 40,height: 40)
                    }
                    .padding()
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ThemeDisco()
//        .environmentObject(TabBarState())
}
