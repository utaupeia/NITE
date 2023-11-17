//
//  MembershipViewModel.swift
//  niteclub
//
//  Created by +++ on 12/3/23.
//

import Foundation
import Combine
import StoreKit

class MembershipViewModel: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    // Published properties to update the UI
    @Published var memberships: [SKProduct] = []
    @Published var isMembershipActive: Bool = false
    @Published var isLoading: Bool = false
    @Published var error: Error?
    @Published var showError: Bool = false

    private var productRequest: SKProductsRequest?
    private var cancellables = Set<AnyCancellable>()

    // Product IDs for the Membership
    private let membershipProductIDs: Set<String> = ["membership.monthly"]

    override init() {
        super.init()
        fetchMemberships()
        setupPaymentQueue()
    }

    // Fetch available memberships from the App Store
    func fetchMemberships() {
        isLoading = true
        productRequest = SKProductsRequest(productIdentifiers: membershipProductIDs)
        productRequest?.delegate = self
        productRequest?.start()
    }

    // Set up payment queue listener
    private func setupPaymentQueue() {
        SKPaymentQueue.default().add(self)
    }

    // Purchase a membership
    func purchaseMembership(_ product: SKProduct) {
        // Logic to initiate the purchase with StoreKit
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }

    // Restore purchases
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    // Handle transaction updates (success, failure, restored, etc.)
    private func handleTransactionUpdate(_ transaction: SKPaymentTransaction) {
        // Implementation depends on your app logic
        // ...
    }

    // Handle errors
    func handleError(_ error: SKError) {
        // Your existing error handling logic...
        self.showError = true
    }


    // Custom error types
    enum MembershipError: Error {
        case cannotMakePayments
        // Define other error types as needed
    }
}

// MARK: - SKProductsRequestDelegate
extension MembershipViewModel {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            self.memberships = response.products
            print("Fetched products: \(self.memberships)")
            self.isLoading = false
        }
    }

    func request(_ request: SKRequest, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.error = error
            print("Error fetching products: \(error.localizedDescription)")
            self.isLoading = false
        }
    }
}

extension SKProduct {
    var localizedPrice: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale
        return formatter.string(from: self.price)
    }
}


// MARK: - SKPaymentTransactionObserver
extension MembershipViewModel {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased, .restored:
                handleTransactionUpdate(transaction)
                SKPaymentQueue.default().finishTransaction(transaction)
            case .failed:
                if let error = transaction.error as? SKError {
                    handleError(error)
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            default:
                break
            }
        }
    }

    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        // Handle restoration completion
    }

    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        // Handle restoration failure
    }
}
