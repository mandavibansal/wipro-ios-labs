import Foundation
protocol Displayable {
    func display()
}

struct Student: Displayable {
    var name: String
    var marks: Int

    func display() {
        print("student name: \(name)")
        print("marks: \(marks)")
    }
}
struct Course: Displayable {
    var name: String
    var duration: Int

    func display() {
        print("course name: \(name)")
        print("Duration: \(duration) days")
    }
}
 print("PROTOCOL DEMONSTRATIONS")

 let student = Student(name: "Aarvi", marks: 89)
 let course = Course(name: "Java",  duration: 35)

 student.display()
 course.display()

 extension String {
  var wordCount: Int {
    return self.split(separator: " ").count
  }
 }

 print("\n STRING EXTENSION")

 let message = "Java is easy to learn"

 print("Message:",message)
 print("Word Count:",message.wordCount)

 struct Stack<T> {
    private var items: [T] = []

    mutating func push(_ item:T) {
        items.append(item)
    }
    mutating func pop() -> T? {
        return items.popLast()
    }
    func peek() -> T? {
        return items.last
    }
    var isEmpty: Bool {
        return items.isEmpty
    }
}

print("\n INTEGER STACK")

var intStack = Stack<Int>()

intStack.push(10)
intStack.push(20)
intStack.push(30)

print("Top element:",intStack.peek() ?? 0)
print("Removed element:",intStack.pop() ?? 0)
print("Stack empty:",intStack.isEmpty)

func showDetails<T: Displayable>(item: T) {
    item.display()
}

print("\n GENERIC FUNCTION")

showDetails(item: student)
showDetails(item: course)

protocol StackProtocol {
    associatedtype Element

    mutating func push(_ item: Element)
    mutating func pop() -> Element?
    func peek() -> Element?
    var isEmpty: Bool { get }
}

extension Stack: StackProtocol {}

print("\n----- STRING STACK -----")

var stringStack = Stack<String>()

stringStack.push("Swift")
stringStack.push("Java")
stringStack.push("Python")

print("Top element:", stringStack.peek() ?? "Empty")
print("Removed element:", stringStack.pop() ?? "Empty")



print("\n----- TESTING -----")

// Test 1:
assert(student.marks == 85)

// Test 2:
assert(course.name == "Swift")

// Test 3:
assert(message.wordCount == 5)

// Test 4:
assert(intStack.peek() == 20)

// Test 5:
assert(intStack.pop() == 20)

// Test 6:
assert(stringStack.peek() == "Java")

// Test 7:
assert(stringStack.pop() == "Java")

// Test 8:
assert(intStack.isEmpty == false)


