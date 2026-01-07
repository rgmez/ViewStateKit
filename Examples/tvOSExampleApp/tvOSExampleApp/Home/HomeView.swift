//
//  HomeView.swift
//  tvOSExampleApp
//
//  Created by Roberto Gómez on 7/1/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            List {
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
            .navigationTitle("Examples")
        }
    }
}
