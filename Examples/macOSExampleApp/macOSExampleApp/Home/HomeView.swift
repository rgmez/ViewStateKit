//
//  HomeView.swift
//  macOSExampleApp
//
//  Created by Roberto Gómez on 7/1/26.
//

import SwiftUI
import ViewStateKit

struct HomeView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Examples") {
                    NavigationLink("Search Results (full state)") {
                        SearchResultsView()
                    }

                    NavigationLink("Recent Searches (can't fail)") {
                        RecentSearchesView()
                    }

                    NavigationLink("Account Summary (never empty)") {
                        AccountSummaryView()
                    }
                }
            }
        }
        .frame(minWidth: 700, minHeight: 500)
    }
}
