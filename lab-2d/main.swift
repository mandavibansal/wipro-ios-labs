import Foundation

enum ValidationError: Error {
    case emptyName
    case invalidMark
    case invalidID
}

struct Student {
    let id: Int
    let name: String
    let mark: Int
}

func registerStudent(id: Int, name: String, mark: Int) throws -> Student {

    if name.trimmingCharacters(in: .whitespaces).isEmpty {
        throw ValidationError.emptyName
    }

    if mark < 0 || mark > 100 {
        throw ValidationError.invalidMark
    }

    if id <= 0 {
        throw ValidationError.invalidID
    }

    return Student(id: id, name: name, mark: mark)
}

func showRegistration(id: Int, name: String, mark: Int) {

    do {
        let student = try registerStudent(id: id, name: name, mark: mark)

        print("Registration successful!")
        print("ID: \(student.id)")
        print("Name: \(student.name)")
        print("Mark: \(student.mark)")

    } catch ValidationError.emptyName {
        print("Error: Student name cannot be empty.")

    } catch ValidationError.invalidMark {
        print("Error: Mark must be between 0 and 100.")

    } catch ValidationError.invalidID {
        print("Error: Student ID must be greater than 0.")

    } catch {
        print("Something went wrong. Please try again.")
    }
}

print("STUDENT REGISTRATION ")

showRegistration(id: 101, name: "Aarav", mark: 85)
showRegistration(id: 102, name: "", mark: 75)
showRegistration(id: 0, name: "Riya", mark: 90)
showRegistration(id: 103, name: "Karan", mark: 120)
showRegistration(id: 104, name: "Ananya", mark: 92)

func findStudent(id: Int) -> Student? {

    if id == 101 {
        return Student(id: 101, name: "Aarav", mark: 85)
    }

    return nil
}

print("\n OPTIONAL RETURN ")

if let student = findStudent(id: 101) {
    print("Student found: \(student.name)")
} else {
    print("Student not found.")
}

if let student = findStudent(id: 999) {
    print("Student found: \(student.name)")
} else {
    print("Student not found.")
}

func getStudent(id: Int) -> Result<Student, ValidationError> {

    if id == 101 {
        return .success(Student(id: 101, name: "Aarav", mark: 85))
    }

    return .failure(ValidationError.invalidID)
}

print("\n RESULT TYPE ")

let result = getStudent(id: 101)

switch result {
case .success(let student):
    print("Student found: \(student.name)")

case .failure(let error):
    print("Could not find student: \(error)")
}

let failedResult = getStudent(id: 999)

switch failedResult {
case .success(let student):
    print("Student found: \(student.name)")

case .failure:
    print("Student not found. Please check the ID.")
}

func fetchStudentFromServer() -> Result<Student, StringError> {

    let serverIsAvailable = true

    if serverIsAvailable {
        return .success(Student(id: 105, name: "Meera", mark: 88))
    } else {
        return .failure(StringError.networkUnavailable)
    }
}

enum StringError: Error {
    case networkUnavailable
}

print("\n NETWORK RESPONSE ")

let networkResult = fetchStudentFromServer()

switch networkResult {
case .success(let student):
    print("Student data received: \(student.name)")

case .failure:
    print("Unable to connect to the server. Please try again later.")
}