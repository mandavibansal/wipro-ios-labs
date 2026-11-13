
import SwiftUI

class CourseViewModel: ObservableObject {

    @Published var courses: [Course] = [
        Course(
            title: "SwiftUI Basics",
            category: "iOS Development",
            description: "Learn how to build apps using SwiftUI.",
            duration: "4 Weeks"
        ),
        Course(
            title: "Python Programming",
            category: "Programming",
            description: "Learn Python and its basic concepts.",
            duration: "6 Weeks"
        ),
        Course(
            title: "Web Development",
            category: "Development",
            description: "Learn HTML, CSS and JavaScript.",
            duration: "8 Weeks"
        ),
        Course(
            title: "Machine Learning",
            category: "Artificial Intelligence",
            description: "Understand machine learning fundamentals.",
            duration: "10 Weeks"
        )
    ]
}
