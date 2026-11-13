
import SwiftUI

struct CourseCardView: View {
    let course: Course

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.blue.opacity(0.12))
                    .frame(height: 130)

                Image(systemName: course.symbol)
                    .font(.system(size: 45))
                    .foregroundColor(.blue)
            }

            HStack {
                Text(course.category)
                    .font(.caption)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(Capsule())

                Spacer()

                Text(course.duration)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Text(course.name)
                .font(.headline)
                .foregroundColor(.primary)

            Text(course.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)

            HStack {
                Text(course.level)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Spacer()

                Image(systemName: "arrow.right")
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(18)
    }
}

