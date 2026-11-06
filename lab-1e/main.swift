import Foundation

struct Course {
    var name: String
    var duration: Int
}

print("VALUE TYPE ")

var course1 = Course(name: "Swift", duration: 30)
var course2 = course1

course2.name = "Java"
course2.duration = 45

print("Course 1: \(course1.name), \(course1.duration) days")
print("Course 2: \(course2.name), \(course2.duration) days")

class CourseManager {
    var name: String

    init(name: String) {
        self.name = name
    }

    deinit {
        print("CourseManager object released")
    }
}

print("\n REFERENCE TYPE ")

var manager1: CourseManager? = CourseManager(name: "Swift")
var manager2 = manager1

manager2?.name = "Python"

print("Manager 1: \(manager1?.name ?? "Not available")")
print("Manager 2: \(manager2?.name ?? "Not available")")

manager1 = nil
manager2 = nil

print("\n TEACHER AND CLASSROOM ")

class Teacher {
    var name: String
    weak var classroom: Classroom?

    init(name: String) {
        self.name = name
    }

    deinit {
        print("Teacher object released")
    }
}

class Classroom {
    var roomNumber: Int
    var teacher: Teacher?

    init(roomNumber: Int) {
        self.roomNumber = roomNumber
    }

    deinit {
        print("Classroom object released")
    }
}

var classroom: Classroom? = Classroom(roomNumber: 101)
var teacher: Teacher? = Teacher(name: "Mr. Sharma")

classroom?.teacher = teacher
teacher?.classroom = classroom

print("Teacher: \(teacher?.name ?? "Unknown")")
print("Room Number: \(classroom?.roomNumber ?? 0)")

teacher = nil
classroom = nil

print("\n STRONG REFERENCE CYCLE ")

class Sample {
    var name = "Swift"
    var action: (() -> Void)?

    func createStrongReference() {
        action = {
            print(self.name)
        }
    }

    func createWeakReference() {
        action = { [weak self] in
            guard let self = self else {
                return
            }

            print(self.name)
        }
    }

    deinit {
        print("Sample object released")
    }
}

var sample: Sample? = Sample()

sample?.createStrongReference()
sample?.action?()

sample?.action = nil
sample = nil

print("\n WEAK CAPTURE ")

var sample2: Sample? = Sample()

sample2?.createWeakReference()
sample2?.action?()

sample2 = nil