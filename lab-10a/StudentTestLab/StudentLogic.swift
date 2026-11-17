import Foundation

struct Student: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let marks: [Double]
    let average: Double
    let grade: String
}

struct GradeCalculator {

    func calculateAverage(_ marks: [Double]) -> Double? {

        guard !marks.isEmpty else {
            return nil
        }

        guard marks.allSatisfy({ $0 >= 0 && $0 <= 100 }) else {
            return nil
        }

        return marks.reduce(0, +) / Double(marks.count)
    }

    func calculateGrade(_ average: Double) -> String {

        switch average {
        case 90...100:
            return "A"
        case 80..<90:
            return "B"
        case 70..<80:
            return "C"
        case 60..<70:
            return "D"
        default:
            return "F"
        }
    }
}

struct StudentFormValidator {

    func isValid(name: String, marks: [Double]) -> Bool {

        let trimmedName = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !trimmedName.isEmpty else {
            return false
        }

        guard !marks.isEmpty else {
            return false
        }

        return marks.allSatisfy { $0 >= 0 && $0 <= 100 }
    }
}

class StudentViewModel {

    private(set) var students: [Student]

    private let calculator = GradeCalculator()
    private let validator = StudentFormValidator()

    init(students: [Student] = []) {
        self.students = students
    }

    func addStudent(name: String, marks: [Double]) -> Bool {

        guard validator.isValid(name: name, marks: marks) else {
            return false
        }

        guard let average = calculator.calculateAverage(marks) else {
            return false
        }

        let grade = calculator.calculateGrade(average)

        let student = Student(
            name: name.trimmingCharacters(in: .whitespacesAndNewlines),
            marks: marks,
            average: average,
            grade: grade
        )

        students.append(student)

        return true
    }
}