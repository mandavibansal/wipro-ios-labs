
import SwiftUI

struct StateDemoView: View {

    @StateObject private var viewModel = StateViewModel()

    var body: some View {

        VStack(spacing: 20) {

            Text("Fetch State Demo")
                .font(.largeTitle)

            Group {
                switch viewModel.state {

                case .loading:
                    ProgressView("Loading data...")

                case .success(let message):
                    Text(message)
                        .foregroundColor(.green)

                case .error(let message):
                    Text(message)
                        .foregroundColor(.red)

                case .cancelled:
                    Text("Request Cancelled")
                        .foregroundColor(.orange)
                }
            }

            Button("Fetch Successfully") {
                viewModel.fetchData()
            }

            Button("Fetch With Error") {
                viewModel.fetchData(shouldFail: true)
            }

            Button("Cancel Request") {
                viewModel.cancelFetch()
            }
        }
        .padding()
    }
}
