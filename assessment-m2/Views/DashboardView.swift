
import SwiftUI

struct DashboardView: View {

    @StateObject private var viewModel = DashboardViewModel()

    var body: some View {

        VStack(spacing: 20) {

            Text("Dashboard")
                .font(.largeTitle)

            if viewModel.isLoading {
                ProgressView("Loading...")
            } else {
                Text("Welcome, \(viewModel.userName)")

                Text("Total Tasks: \(viewModel.totalTasks)")
            }

            Button("Fetch Data") {
                Task {
                    await viewModel.loadDashboard()
                }
            }
        }
        .padding()
    }
}
