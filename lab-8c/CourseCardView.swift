
import SwiftUI

struct CourseCardView: View {

    let course: Course
    @Binding var isFavourite: Bool

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(course.title)
                    .font(.headline)

                Text(course.category)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text(course.duration)
                    .font(.caption)
            }

            Spacer()

            Button {
                isFavourite.toggle()
            } label: {
                Image(systemName: isFavourite ? "heart.fill" : "heart")
                    .foregroundColor(isFavourite ? .red : .gray)
                    .font(.title2)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
