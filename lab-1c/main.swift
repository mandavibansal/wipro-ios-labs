import Foundation
print("COURSE MANAGEMENT")
var courses = ["Python","Swift","Java","C++"]

print("Original courses:",courses)

courses.append("Machine Learning")
print("adding course:",courses)

if let index = courses.firstIndex(of: "C++"){
    courses.remove(at: index)
}
print("removed course:", courses)

courses.sort()
print("sorted courses:",courses)

let filteredCourses = courses.filter{ $0.hasPrefix("S")}

print("courses starting with S:",filteredCourses)

if courses.contains("Swift"){
    print("swift course is available.")
} else{
    print("siwft course isn't available.")
}
print("\nSTUDENT ID MANAGEMENT")

let studentsID = [101,104,105,102,103,102,101,105]

let uniqueIds = Set(studentsID)

print("Original ID:",studentsID)
print("Unique ID:",uniqueIds)
print("total unique IDS:",uniqueIds.count)

print("\n STUDENT MARKS")

let studentMarks = [
    101: 76,
    102: 98,
    103: 67,
    104: 99,
    105: 87
]

if let topper = studentMarks.max(by: { $0.value < $1.value}){
    print("Topper ID:",topper.key)
    print("Highest marks:",topper.value)
}

print("\n students scoring below 80:")
for(id,marks) in studentMarks{
    if marks<80{
        print("Student ID:",id,"Marks:",marks)
    }
}

print ("\n TASK PRIORITY")

enum TaskPriority {
    case low
    case medium
    case high
    case urgent
}

let priority = TaskPriority.high

switch priority {
case .low:
    print("Priority: low -> can be done later")

case .medium:
    print("Priority: medium->complete soon")

case .high:
    print("Piorirty: high-> complete asap")
    
case .urgent:
    print("Priority: urgent-> complete immediately")
}

print("\n PROGRAM COMPLETED")

