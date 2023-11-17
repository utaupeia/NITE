//
//  ContentView.swift
//  niteclub
//
//  Created by +++ on 10/20/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

        @State private var navigationPath = NavigationPath()

        var body: some View {
            ZStack {
                Blur(style: .dark).ignoresSafeArea()
                ThemeDisco()
            }
//            NavigationStack(path: $navigationPath) {
//                VStack {
//                    Button("Go to Details View") {
//                        navigationPath.append("DetailsView")
//                    }
//                }
//                .navigationDestination(for: String.self) { identifier in
//                    switch identifier {
//                    case "DetailsView":
//                        DetailsView(navigationPath: $navigationPath)
//                    default:
//                        Text("Unknown destination")
//                    }
//                }
//            }
        }
    }


struct DetailsView: View {
    @Binding var navigationPath: NavigationPath

    var body: some View {
        VStack {
            Text("Details View")
            Button("Go to Another View") {
                navigationPath.append("AnotherView")
            }
        }
    }
}


struct AnotherView: View {
    var body: some View {
        Text("Another View")
            .padding()
    }
}

//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//#if os(macOS)
//            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
//#endif
//            .toolbar {
//#if os(iOS)
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//#endif
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
    

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
//}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

