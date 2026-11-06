import Foundation

let studentName: String = "Mandavi"
let rollNumber: Int = 101
let attendance: Double = 90.0


var marks: [Double] = [85, 90, 78, 88, 92]

let totalMarks = marks.reduce(0, +)
let maximumMarks = Double(marks.count * 100)

let averageMarks = totalMarks / Double(marks.count)
let percentage = (totalMarks / maximumMarks) * 100


let a = 20
let b = 10

print("Addition:", a + b)
print("Subtraction:", a - b)
print("Multiplication:", a * b)
print("Division:", a / b)
print("Remainder:", a % b)


print("\nComparison Operators")

print("a > b:", a > b)
print("a < b:", a < b)
print("a == b:", a == b)
print("a != b:", a != b)

let hasPassed = percentage >= 40
let hasRequiredAttendance = attendance >= 75

let isEligible = hasPassed && hasRequiredAttendance

print("\nLogical Operators")
print("Has Passed:", hasPassed)
print("Required Attendance:", hasRequiredAttendance)
print("Eligible:", isEligible)


var score = 50

score += 10
print("\nAfter += 10:", score)

score -= 5
print("After -= 5:", score)

score *= 2
print("After *= 2:", score)


var optionalName: String? = nil

let finalName = optionalName ?? "Unknown Student"

print("\nStudent Name:", finalName)


print("\nStudent Result")

if percentage >= 40 && attendance >= 75 {
    print("Result: PASS")
} else {
    print("Result: FAIL")
}


func calculateGrade(_ percentage: Double) -> String {

    switch percentage {
    case 90...100:
        return "A+"
    case 80..<90:
        return "B"
    case 70..<80:
        return "C"
    case 60..<70:
        return "D"
    case 40..<60:
        return "E"
    default:
        return "F"
    }
}

let grade = calculateGrade(percentage)


let minimumAttendance = 75.0

if marks.allSatisfy({ $0 >= 0 && $0 <= 100 }) {
    print("\nMarks Validation: Valid")
} else {
    print("\nMarks Validation: Invalid")
}

if attendance >= 0 && attendance <= 100 {
    print("Attendance Validation: Valid")
} else {
    print("Attendance Validation: Invalid")
}


print("\nSTUDENT REPORT ")

print("Student Name:", studentName)
print("Roll Number:", rollNumber)
print("Marks:", marks)
print("Total Marks:", totalMarks)
print("Maximum Marks:", maximumMarks)

print("Average Marks:", String(format: "%.2f", averageMarks))
print("Percentage:", String(format: "%.2f%%", percentage))
print("Attendance:", attendance, "%")

print("Result:", isEligible ? "PASS" : "FAIL")
print("Grade:", grade)