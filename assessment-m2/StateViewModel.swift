
import Foundation

enum FetchState {
    case loading
    case success(String)
    case error(String)
    case cancelled
}

@MainActor
class StateViewModel: ObservableObject {

    @Published var state: FetchState = .loading

    private var fetchTask: Swift.Task<Void, Never>?

    func fetchData(shouldFail: Bool = false) {

        fetchTask?.cancel()

        fetchTask = Task {

            state = .loading

            do {
                try await Task.sleep(for: .seconds(3))

                try Task.checkCancellation()

                if shouldFail {
                    throw NSError(
                        domain: "FetchError",
                        code: 1,
                        userInfo: [
                            NSLocalizedDescriptionKey:
                            "Something went wrong!"
                        ]
                    )
                }

                state = .success("Data fetched successfully!")

            } catch is CancellationError {
                state = .cancelled

            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }

    func cancelFetch() {
        fetchTask?.cancel()
    }
}
