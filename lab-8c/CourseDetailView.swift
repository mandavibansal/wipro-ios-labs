
import SwiftUI

struct CourseDetailView: View {

    @Binding var course: Course

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Text(course.title)
                .font(.largeTitle)
                .bold()

            Text(course.category)
                .font(.headline)
                .foregroundColor(.blue)

            Text(course.description)
                .font(.body)

            Text("Duration: \(course.duration)")
                .font(.subheadline)

            Button {
                course.isFavourite.toggle()
            } label: {
                Label(
                    course.isFavourite ? "Remove Favourite" : "Add to Favourites",
                    systemImage: course.isFavourite ? "heart.fill" : "heart"
                )
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(course.isFavourite ? Color.red : Color.blue)
                .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
