
import SwiftUI

@MainActor
class PostViewModel: ObservableObject {

    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = PostService()

    func fetchPosts() async {

        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            posts = try await service.fetchPosts()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

struct ContentView: View {

    @StateObject private var viewModel = PostViewModel()

    var body: some View {

        NavigationStack {

            Group {

                if viewModel.isLoading {

                    ProgressView("Loading posts...")

                } else if let error = viewModel.errorMessage {

                    VStack(spacing: 15) {
                        Text(error)
                            .multilineTextAlignment(.center)

                        Button("Retry") {
                            Task {
                                await viewModel.fetchPosts()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()

                } else {

                    List(viewModel.posts) { post in

                        NavigationLink {
                            PostDetailView(post: post)
                        } label: {
                            VStack(alignment: .leading, spacing: 8) {

                                Text(post.title)
                                    .font(.headline)

                                Text(post.body)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
            .navigationTitle("Posts")
            .task {
                if viewModel.posts.isEmpty &&
                    viewModel.errorMessage == nil {
                    await viewModel.fetchPosts()
                }
            }
        }
    }
}
