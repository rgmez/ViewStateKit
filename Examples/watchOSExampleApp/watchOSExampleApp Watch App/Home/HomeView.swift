//
//  HomeView.swift
//  watchOSExampleApp Watch App
//
//  Created by Roberto Gómez on 8/1/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Examples") {
                    NavigationLink("Search Results") {
                        SearchResultsView()
                    }

                    NavigationLink("Recent Searches") {
                        RecentSearchesView()
                    }

                    NavigationLink("Account Summary") {
                        AccountSummaryView()
                    }
                }
            }
            .navigationTitle("ViewStateKit")
        }
    }
}
