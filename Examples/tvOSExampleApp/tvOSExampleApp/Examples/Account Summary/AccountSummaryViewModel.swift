//
//  AccountSummaryViewModel.swift
//  tvOSExampleApp
//
//  Created by Roberto Gómez on 7/1/26.
//

import Foundation
import ViewStateKit

typealias AccountSummaryState = ViewStateWithoutEmpty<AccountSummary, ErrorDisplayModel>

@MainActor
@Observable
final class AccountSummaryViewModel {
    private(set) var state: AccountSummaryState = .idle
    private let accountSummary = AccountSummary(
        planName: "Pro I",
        usedStorage: "8.2 GB",
        totalStorage: "2 TB"
    )

    func load(outcome: AccountSummaryOutcome = .success) async {
        state = .loading
        try? await Task.sleep(nanoseconds: 700_000_000)

        state = switch outcome {
        case .success: .content(accountSummary)
        case .failure: .error(.generic())
        }
    }
}

struct AccountSummary: Equatable {
    let planName: String
    let usedStorage: String
    let totalStorage: String
}

enum AccountSummaryOutcome: String, CaseIterable, Identifiable {
    case success, failure
    var id: String { rawValue }
}
