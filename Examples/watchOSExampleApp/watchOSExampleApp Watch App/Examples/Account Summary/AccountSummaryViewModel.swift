//
//  AccountSummaryViewModel.swift
//  watchOSExampleApp Watch App
//
//  Created by Roberto Gómez on 8/1/26.
//

import Foundation
import ViewStateKit

typealias AccountSummaryState = ViewStateWithoutEmpty<[String], ErrorDisplayModel>

@MainActor
@Observable
final class AccountSummaryViewModel {
    private(set) var state: AccountSummaryState = .idle

    private let accountSummaryLines: [String] = [
        "Roberto Gómez · Pro Plan",
        "Storage: 48.2 GB of 2 TB",
        "Renewal: Feb 12, 2026",
        "Backups: Enabled · Wi-Fi only",
        "Security: 2FA enabled"
    ]

    func load(outcome: AccountSummaryOutcome = .success) async {
        state = .loading
        try? await Task.sleep(nanoseconds: 700_000_000)

        state = switch outcome {
        case .success:
            .content(accountSummaryLines)
        case .failure:
            .error(.init(
                title: "Something went wrong",
                message: "We couldn't refresh your account data.",
                recoverySuggestion: "Please try again."
            ))
        }
    }

    func reset() {
        state = .idle
    }
}

enum AccountSummaryOutcome: String, CaseIterable, Identifiable {
    case success, failure
    var id: String { rawValue }
}
