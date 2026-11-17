import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = ExpenseViewModel()

    var body: some View {

        TabView {

            DashboardView(viewModel: viewModel)
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            TransactionsView(viewModel: viewModel)
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }

            AnalyticsView(viewModel: viewModel)
                .tabItem {
                    Label("Analytics", systemImage: "chart.pie")
                }
        }
    }
}