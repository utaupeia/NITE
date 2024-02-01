//
//  DemoPop.swift
//  niteclub
//
//  Created by +++ on 1/28/24.
//

//import NavigationTransitions
import SwiftUI

struct DemoPop: View {

    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section("List One") {
                    NavigationLink("Navigate to View 1", value: "View 1")
                    NavigationLink("Navigate to View 2", value: "View 2")
                }
            }
            .navigationDestination(for: String.self) { textDesc in
                VStack {
                    customBackButton // Custom back button
                    Text(textDesc).padding()
                    Button("Navigate to View 3") {
                        path.append("View 3")
                    }.padding()

                    Button("Pop to Root View") {
                        path.removeLast(path.count)
                    }.padding()
                }
            }
            .navigationTitle("Test Pop To Root")
        }
    }

    // Custom back button view
    private var customBackButton: some View {
        Button(action: {
            // Pop the current view
            if path.count > 0 {
                path.removeLast()
            }
        }) {
            HStack {
                Image(systemName: "chevron.left") // Customize with your own image or view
                Text("Back")
            }
        }
        .padding()
    }
}



struct DemoPop_Previews: PreviewProvider {
    static var previews: some View {
        DemoPop()
    }
}

