import Foundation

actor SafeCounter {
    private var count = 0

    func increment() {
        count += 1
    }

    func getCount() -> Int {
        return count
    }
}

let safeCounter = SafeCounter()

Task {
    for _ in 0..<1000 {
        await safeCounter.increment()
    }

    let result = await safeCounter.getCount()
    print("Safe Counter:", result)
}
