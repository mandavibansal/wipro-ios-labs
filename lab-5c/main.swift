import Foundation

struct Course {
    let id: String
    let name: String
    let duration: String
}
enum CourseError: Error {
    case courseNotFound
}

func fetchCourse(id: String, shouldFail: Bool = false) async throws -> Course {

    print("Fetching course: \(id)")

    let delays: [String: UInt64] = [
        "C101": 2,
        "C102": 3,
        "C103": 1,
        "C104": 2,
        "C105": 3
    ]

    let delay = delays[id] ?? 2

    try await Task.sleep(for: .seconds(delay))

    if shouldFail {
        throw CourseError.courseNotFound
    }

    let courseNames: [String: String] = [
        "C101": "Swift",
        "C102": "Java",
        "C103": "Python",
        "C104": "iOS Development",
        "C105": "Data Science"
    ]

    return Course(
        id: id,
        name: courseNames[id] ?? "Unknown",
        duration: "3 Months"
    )
}

func fetchCoursesTogether(ids: [String], failingID: String? = nil) async -> [Course] {

    let courses = await withTaskGroup(of: Course?.self) { group in

        for id in ids {
            group.addTask {
                do {
                    let course = try await fetchCourse(
                        id: id,
                        shouldFail: id == failingID
                    )
                    return course
                } catch {
                    print("Failed to fetch: \(id)")
                    return nil
                }
            }
        }

        var results: [Course] = []

        for await course in group {
            if let course = course {
                results.append(course)
            }
        }

        return results
    }

    return courses
}

func fetchSequentially(ids: [String]) async {

    let startTime = Date()

    for id in ids {
        do {
            let course = try await fetchCourse(id: id)
            print("Fetched: \(course.name)")
        } catch {
            print("Error fetching \(id)")
        }
    }

    let elapsedTime = Date().timeIntervalSince(startTime)

    print("Sequential time: \(elapsedTime) seconds")
}

func fetchConcurrently(ids: [String]) async {

    let startTime = Date()

    let courses = await fetchCoursesTogether(ids: ids)

    for course in courses {
        print("Fetched: \(course.name)")
    }

    let elapsedTime = Date().timeIntervalSince(startTime)

    print("Concurrent time: \(elapsedTime) seconds")
}

func cancellationDemo() async {

    print("\n Cancellation Demo ")

    let task = Task {
        try await fetchCourse(id: "C102")
    }

    try? await Task.sleep(for: .milliseconds(500))

    // Cancel the task
    task.cancel()

    do {
        let course = try await task.value
        print("Fetched: \(course.name)")
    } catch {
        print("Task was cancelled or failed")
    }
}
let courseIDs = ["C101", "C102", "C103", "C104", "C105"]

Task {
    print("\nSequential Fetching ")
    await fetchSequentially(ids: courseIDs)

    print("\n Concurrent Fetching ")
    await fetchConcurrently(ids: courseIDs)

    print("\n Partial Results Demo ")

    let results = await fetchCoursesTogether(
        ids: courseIDs,
        failingID: "C103"
    )

    print("Successful courses: \(results.count)")

    for course in results {
        print("\(course.id): \(course.name)")
    }

    await cancellationDemo()
}
