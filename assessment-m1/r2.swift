struct Stack<Element> {

    var items: [Element] = []

    mutating func push(_ item: Element) {
        items.append(item)
    }

    mutating func pop() -> Element? {
        return items.popLast()
    }

    func peek() -> Element? {
        return items.last
    }
}

print("\nINTEGER STACK ")

var numberStack = Stack<Int>()

numberStack.push(10)
numberStack.push(20)
numberStack.push(30)

print("Integer Stack:", numberStack.items)

if let top = numberStack.peek() {
    print("Top element:", top)
}

if let removed = numberStack.pop() {
    print("Removed element:", removed)
}

print("Stack after removal:", numberStack.items)


print("\n STRING STACK ")

var nameStack = Stack<String>()

nameStack.push("Rahul")
nameStack.push("Priya")
nameStack.push("Aman")

print("Name Stack:", nameStack.items)

if let removedName = nameStack.pop() {
    print("Removed name:", removedName)
}
print("Stack after removal:", nameStack.items)