import SwiftUI

struct LabCourse: Identifiable, Hashable {
    let id: Int
    let name: String
    let category: String
    let description: String
}

class LabCourseStore: ObservableObject {
    @Published var courses = [
        LabCourse(
            id: 1,
            name: "Swift Programming",
            category: "iOS Development",
            description: "Learn Swift basics and build iOS applications."
        ),
        LabCourse(
            id: 2,
            name: "Web Development",
            category: "Development",
            description: "Learn HTML, CSS and JavaScript."
        ),
        LabCourse(
            id: 3,
            name: "Data Science",
            category: "Technology",
            description: "Explore Python, data analysis and machine learning."
        ),
        LabCourse(
            id: 4,
            name: "UI/UX Design",
            category: "Design",
            description: "Learn how to design user-friendly applications."
        )
    ]

    @Published var favourites: Set<Int> = []

    func toggleFavourite(for course: LabCourse) {
        if favourites.contains(course.id) {
            favourites.remove(course.id)
        } else {
            favourites.insert(course.id)
        }
    }
}

struct ContentView: View {

    @StateObject private var store = LabCourseStore()

    var body: some View {
        NavigationStack {
            List {
                Section("All Courses") {
                    ForEach(store.courses) { course in
                        NavigationLink {
                            CourseDetailView(
                                course: course,
                                store: store
                            )
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(course.name)
                                        .font(.headline)

                                    Text(course.category)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()

                                if store.favourites.contains(course.id) {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
            .navigationTitle("Course Explorer")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        FavouritesView(store: store)
                    } label: {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {
                        RegistrationView()
                    } label: {
                        Image(systemName: "person.crop.circle.badge.plus")
                    }
                }
            }
        }
    }
}

struct CourseDetailView: View {

    let course: LabCourse

    @ObservedObject var store: LabCourseStore

    var isFavourite: Bool {
        store.favourites.contains(course.id)
    }

    var body: some View {
        VStack(spacing: 20) {

            Image(systemName: "book.closed.fill")
                .font(.system(size: 65))
                .foregroundColor(.blue)

            Text(course.name)
                .font(.largeTitle)
                .bold()

            Text(course.category)
                .font(.headline)
                .foregroundColor(.secondary)

            Text(course.description)
                .multilineTextAlignment(.center)
                .padding()

            Button {
                store.toggleFavourite(for: course)
            } label: {
                Label(
                    isFavourite ? "Remove Favourite" : "Add to Favourites",
                    systemImage: isFavourite ? "heart.fill" : "heart"
                )
                .frame(maxWidth: .infinity)
                .padding()
                .background(isFavourite ? Color.red : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FavouritesView: View {

    @ObservedObject var store: LabCourseStore

    var favouriteCourses: [LabCourse] {
        store.courses.filter {
            store.favourites.contains($0.id)
        }
    }

    var body: some View {
        List {
            if favouriteCourses.isEmpty {
                Text("No favourite courses yet.")
                    .foregroundColor(.secondary)
            } else {
                ForEach(favouriteCourses) { course in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(course.name)
                                .font(.headline)

                            Text(course.category)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        Button {
                            store.toggleFavourite(for: course)
                        } label: {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .navigationTitle("My Favourites")
    }
}

struct RegistrationView: View {

    @State private var studentName = ""
    @State private var email = ""
    @State private var selectedCourse = "Swift Programming"

    @State private var isSubmitting = false
    @State private var showSuccess = false
    @State private var errorMessage = ""

    let courseOptions = [
        "Swift Programming",
        "Web Development",
        "Data Science",
        "UI/UX Design"
    ]

    var body: some View {
        Form {

            Section("Student Details") {

                TextField("Enter your name", text: $studentName)

                TextField("Enter your email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }

            Section("Select Course") {

                Picker("Course", selection: $selectedCourse) {
                    ForEach(courseOptions, id: \.self) { course in
                        Text(course)
                    }
                }
            }

            Section {

                Button {
                    registerStudent()
                } label: {
                    HStack {
                        Spacer()

                        if isSubmitting {
                            ProgressView()
                        } else {
                            Text("Register Now")
                        }

                        Spacer()
                    }
                }
                .disabled(isSubmitting)
            }

            if !errorMessage.isEmpty {
                Section("Error") {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
        }
        .navigationTitle("Registration")
        .alert("Registration Successful!", isPresented: $showSuccess) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("\(studentName), you have registered for \(selectedCourse).")
        }
    }

    func registerStudent() {

        errorMessage = ""

        if studentName.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "Please enter your name."
            return
        }

        if !email.contains("@") || !email.contains(".") {
            errorMessage = "Please enter a valid email address."
            return
        }

        isSubmitting = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isSubmitting = false
            showSuccess = true
        }
    }
}
