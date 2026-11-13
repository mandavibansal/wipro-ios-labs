
import SwiftUI

struct CourseDetailView: View {

    let course: Course

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Text(course.name)
                .font(.largeTitle)
                .bold()

            Text(course.category)
                .font(.headline)
                .foregroundColor(.blue)

            Text("Duration: \(course.duration)")
                .font(.title3)

            Text(course.description)
                .font(.body)

            Spacer()
        }
        .padding()
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

