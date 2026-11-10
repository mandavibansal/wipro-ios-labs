
import SwiftUI

struct PostDetailView: View {

    let post: Post

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                Text("Post #\(post.id)")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(post.title)
                    .font(.title)
                    .fontWeight(.bold)

                Divider()

                Text("Post Details")
                    .font(.headline)

                Text(post.body)
                    .font(.body)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Post Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
