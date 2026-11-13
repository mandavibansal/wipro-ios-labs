
import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "book.closed")
                .font(.system(size: 55))
                .foregroundColor(.gray)

            Text("No Courses Available")
                .font(.title2)
                .fontWeight(.semibold)

            Text("There are currently no courses to explore. Please check again later.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

