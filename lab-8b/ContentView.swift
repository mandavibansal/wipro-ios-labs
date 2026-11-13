
import SwiftUI

struct ContentView: View {

    @State private var path: [Course] = []

    let courses = [
        Course(
            name: "Swift",
            category: "iOS Development",
            duration: "4 Weeks",
            description: "Learn Swift basics and build iOS applications."
        ),
        Course(
            name: "Java",
            category: "Programming",
            duration: "6 Weeks",
            description: "Learn object oriented programming using Java."
        ),
        Course(
            name: "Python",
            category: "Programming",
            duration: "5 Weeks",
            description: "Learn Python and solve programming problems."
        ),
        Course(
            name: "UI/UX Design",
            category: "Design",
            duration: "3 Weeks",
            description: "Learn how to design user friendly applications."
        )
    ]

    var body: some View {

        NavigationStack(path: $path) {

            List(courses) { course in

                NavigationLink(value: course) {

                    VStack(alignment: .leading, spacing: 5) {

                        Text(course.name)
                            .font(.headline)

                        Text(course.category)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("My Courses")
            .navigationDestination(for: Course.self) { course in
                CourseDetailView(course: course)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Home") {
                        path.removeAll()
                    }
                }
            }
        }
    }
}

