import Foundation

class UnsafeCounter {
    var count = 0

    func increment() {
        count += 1
    }
}

let counter = UnsafeCounter()

DispatchQueue.concurrentPerform(iterations: 1000) { _ in
    counter.increment()
}

print("Unsafe Counter:", counter.count)