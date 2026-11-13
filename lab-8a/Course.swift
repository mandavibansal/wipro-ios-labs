import Foundation

struct Course: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let description: String
    let duration: String
    let level: String
    let topics: [String]
    let symbol: String
}
