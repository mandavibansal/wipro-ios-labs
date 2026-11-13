
import SwiftUI

struct CourseDetailView: View {
    let course: Course

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.blue.opacity(0.12))
                    .frame(height: 180)

                Image(systemName: course.symbol)
                    .font(.system(size: 65))
                    .foregroundColor(.blue)
            }
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 10) {
                Text(course.category.uppercased())
                    .font(.caption)
                    .foregroundColor(.blue)

                Text(course.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text(course.description)
                    .foregroundColor(.secondary)

                HStack {
                    Label(course.duration, systemImage: "clock")
                    Spacer()
                    Label(course.level, systemImage: "chart.bar")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
            .padding(.horizontal)

            Text("What You'll Learn")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)

            List(course.topics, id: \.self) { topic in
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)

                    Text(topic)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

