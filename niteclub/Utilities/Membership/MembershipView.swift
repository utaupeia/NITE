//
//  MembershipView.swift
//  niteclub
//
//  Created by +++ on 12/3/23.
//

import SwiftUI
import StoreKit

struct MembershipView: View {
    @StateObject var viewModel = MembershipViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Products")
            if viewModel.isLoading {
                ProgressView()
            } else {
                ForEach(viewModel.memberships, id: \.productIdentifier) { product in
                    Button {
                        viewModel.purchaseMembership(product)
                    } label: {
                        Text("\(product.localizedPrice ?? "N/A") - \(product.localizedTitle)")
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchMemberships()
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(title: Text("Error"), message: Text(viewModel.error?.localizedDescription ?? "Unknown error"))
        }
    }
}


#Preview {
    MembershipView()
}
