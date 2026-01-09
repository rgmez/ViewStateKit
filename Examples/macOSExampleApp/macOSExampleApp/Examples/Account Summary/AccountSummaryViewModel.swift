//
//  AccountSummaryViewModel.swift
//  macOSExampleApp
//
//  Created by Roberto Gómez on 7/1/26.
//

import Foundation
import ViewStateKit

typealias AccountSummaryState = ViewStateWithoutEmpty<[String], ErrorDisplayModel>

@MainActor
@Observable
final class AccountSummaryViewModel {
    private(set) var state: AccountSummaryState = .idle
    private let accountSummaryLines = [
        "Roberto Gómez · Pro Plan",
        "Storage: 48.2 GB of 2 TB",
        "Renewal: Feb 12, 2026",
        "Backups: Enabled · Wi-Fi only",
        "Security: 2FA enabled"
    ]

    func load(outcome: AccountSummaryOutcome = .success) async {
        state = .loading
        try? await Task.sleep(nanoseconds: 800_000_000)

        state = switch outcome {
        case .success: .content(accountSummaryLines)
        case .failure: .error(.generic())
        }
    }

    func updateState(_ newState: AccountSummaryState) {
        state = newState
    }
}

enum AccountSummaryOutcome: String, CaseIterable, Identifiable {
    case success, failure
    var id: String { rawValue }
}
