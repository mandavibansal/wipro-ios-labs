enum ValidationError: Error {
    case emptyName
    case invalidMarks
}

func validateStudent(name: String, marks: Int) throws {

    if name.isEmpty {
        throw ValidationError.emptyName
    }

    if marks < 0 || marks > 100 {
        throw ValidationError.invalidMarks
    }

    print("Student \(name) registered successfully with \(marks) marks")
}

print("\nSTUDENT VALIDATION")

do {
    try validateStudent(name: "Priya", marks: 85)
} catch {
    print("Error:", error)
}

do {
    try validateStudent(name: "", marks: 80)
} catch ValidationError.emptyName {
    print("Error: Student name cannot be empty")
} catch {
    print("Something went wrong")
}
do {
    try validateStudent(name: "Rahul", marks: 120)
} catch ValidationError.invalidMarks {
    print("Error: Marks must be between 0 and 100")
} catch {
    print("Something went wrong")
}
