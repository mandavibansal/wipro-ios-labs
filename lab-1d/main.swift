import Foundation

var marks: [Int: Int] = [
    101: 78,
    102: 99,
    103: 80,
    104: 95
]

func findMarks(id: Int) -> Int? {
    return marks[id]
}

print("IF LET")

if let result = findMarks(id: 101){
    print("Marks: \(result)")
}else{
    print("student not found")
}

print("\n GUARD LET")

func showMarks(id: Int){
    guard let result = findMarks(id: id) else{
        print("marks not available")
        return
    }
    print("student marks: \(result)")
}
showMarks(id: 102)
showMarks(id: 110)

print("\n OPTIONAL CHAINING")
struct Student{
    var name: String
    var address: String?
}

let student: Student? = Student(name: "Ruhi",address: "Noida")

print(student?.address ?? "address not available")

print("\n NIL COALESCING")

let result = findMarks(id: 120)
let finalMarks = result ?? 0

print("Marks: \(finalMarks)")

print("\n DICTIONARY")

var students: [Int: String] = [
    101: "Ruhi",
    102: "Palak",
    103: "Mihika"
]
if let name = students[105]{
    print("Student name: \(name)")
}else{
    print("student ID doesn't exist")
}

print("\n TEXT FIELD")

let name = "  "

if name.trimmingCharacters(in: .whitespaces).isEmpty {
    print("please enter your name")
}else{
    print("Name: \(name)")
}

print("\n PROFILE")

struct Profile {
    var name: String
    var address: String?
    var phone: String?
}

let profile = Profile(
    name: "Ruhi",
    address: nil,
    phone: "9087654678"
)
print("Name: \(profile.name)")
print("Address: \(profile.address ?? "Not provided")")
      print("Phone: \(profile.phone ?? "Not procided")")
