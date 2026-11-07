class Person {

    var name: String
    var pet: Pet?

    init(name: String) {
        self.name = name
        print("\(name) created")
    }

    deinit {
        print("\(name) removed from memory")
    }
}

class Pet {

    var name: String
    weak var owner: Person?

    init(name: String) {
        self.name = name
        print("\(name) created")
    }

    deinit {
        print("\(name) removed from memory")
    }
}

print("\n RETAIN CYCLE FIX ")

var person: Person? = Person(name: "Rahul")
var pet: Pet? = Pet(name: "Bruno")

person?.pet = pet
pet?.owner = person

person = nil
pet = nil

print("Both objects have been released")



/*Retain Cycle and it's fix

A reatin cycle occures when two class objects hold strong references to each other.
Due to this , their reference counts never become 0 and they can't be removed from memory.

In my code , Person class has reference to Pet class and Pet class has a reference to Person class.

To fix this , I changed the owner's reference in Pet class to a weak reference using "weak" keyword.
It doesn't increase the reference count.When Person object is dealllocated, the weak reference automatically becomes nil.

*/