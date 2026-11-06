import Foundation

struct Student {
    var name: String
    var marks: Int
}
 print(" SORTING STUDENTS")

let students = [
    Student(name: "Aryan",marks: 87),
    Student(name: "Rishi", marks: 92),
    Student(name: "Addy", marks:95),
    Student(name: "Ruanshi", marks: 78)
]

let sortedStudents = students.sorted {
    $0.marks > $1.marks
}

for student in sortedStudents {
    print("\(student.name): \(student.marks)")
}


print("\n COMPLETION CLOSURE")
func performTask(completion: () -> Void) {
    print("task completed")
    
    completion()
}
performTask{
    print("Completion closure called")
}

print("\n CLOSURE SYNTAX")

let numbers = [10,20,30,40,50]

let doubledNumbers = numbers.map {
    $0 * 2
}

print("doubled number:",doubledNumbers)

let tripledNumbers = numbers.map { number in
    return number * 3
}

print("tripled numbers: ",tripledNumbers)

print("\n COUNTER CLOSURE")

func createCounter() -> () -> Int{
    var count = 0
    
    let counter = {
        count += 1
        return count
    }
    return counter
}
let counter = createCounter()

print("Count:",counter())
print("Count:",counter())
print("Count:",counter())

print("\n WEAK SELF")

class StudentManager {
    var name = "Student Manager"
    var action: (() -> Void)?
    
    func performAction(){
        action = {[weak self] in
            guard let self = self else {
                print("object no longer exists")
                return
            }
            print("Action performed by \(self.name)")
        }
    }
    deinit {
        print("Student Manager object released")
    }
}

var manager: StudentManager? = StudentManager()

manager?.performAction()
manager?.action?()

manager = nil

print("\n RETRY HELPER")

func retryOperation(times: Int,operation: () -> Bool) {
    for attempt in 1...max(1,times){
        print("Attempt \(attempt)")
        
        if operation() {
            print("Operation successfull")
            return
        }
        print("Operation failed")
    }
    print("all attempts completed")
}
var attempts = 0
retryOperation(times: 3) {
    attempts += 1
    
    if attempts == 3{
        return true
    }
    return false
}

