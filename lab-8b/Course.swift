
import Foundation

struct Course: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let category: String
    let duration: String
    let description: String
}

