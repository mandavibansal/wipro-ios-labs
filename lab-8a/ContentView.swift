import SwiftUI

struct ContentView: View {

    @State private var courses = sampleCourses

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                if courses.isEmpty {
                    EmptyStateView()
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {

                            VStack(alignment: .leading, spacing: 5) {
                                Text("Explore Courses")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)

                                Text("Learn something new every day.")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.top)

                            Text("Available Courses")
                                .font(.title2)
                                .fontWeight(.semibold)

                            VStack(spacing: 18) {
                                ForEach(courses) { course in
                                    NavigationLink {
                                        CourseDetailView(course: course)
                                    } label: {
                                        CourseCardView(course: course)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}