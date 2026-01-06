//
//  HomeView.swift
//  iOSExampleApp
//
//  Created by Roberto Gómez on 5/1/26.
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
            .navigationTitle("ViewStateKit")
        }
    }
}
