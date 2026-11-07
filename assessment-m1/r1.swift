import Foundation

var students = ["Aarush", "Anubhav", "Palak", "Sneha"]

var marks: [String: Int] = [
    "Aarush": 85,
    "Anubhav": 92,
    "Aman": 45,
    "Palak": 68
]

print("STUDENT GRADEBOOK ")

for student in students {
    if let studentMarks = marks[student] {
        print("\(student): \(studentMarks)")
    } else {
        print("\(student): Marks not available")
    }
}

students.append("Karan")
marks["Karan"] = 78

print("\nKaran added successfully")

let searchName = "Palak"

if let studentMarks = marks[searchName] {
    print("\(searchName)'s marks: \(studentMarks)")
} else {
    print("Student not found")
}

let unknownStudent = "Rohan"

if let studentMarks = marks[unknownStudent] {
    print("\(unknownStudent)'s marks: \(studentMarks)")
} else {
    print("\(unknownStudent) is not present")
}
let allMarks = Array(marks.values)

if !allMarks.isEmpty {
    let total = allMarks.reduce(0, +)
    let average = Double(total) / Double(allMarks.count)
    print("Average marks: \(average)")
}

print("\nRESULTS ")

for student in students {
    guard let studentMarks = marks[student] else {
        print("Marks unavailable for \(student)")
        continue
    }

    if studentMarks >= 40 {
        print("\(student): Pass")
    } else {
        print("\(student): Fail")
    }
}
