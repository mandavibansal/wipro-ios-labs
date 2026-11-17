
import SwiftUI

struct ContentView: View {

    let items = Array(1...1000)

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                Text("Performance Lab")
                    .font(.largeTitle)
                    .bold()

                Text("Optimized Version")
                    .foregroundColor(.green)

                List(items, id: \.self) { number in
                    HStack {
                        Text("Item \(number)")
                        Spacer()
                        Text("Value: \(cachedValue(number))")
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("Profiling")
        }
    }

    func cachedValue(_ number: Int) -> Int {
        number * 42
    }
}
