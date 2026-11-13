
import Foundation

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var category: String
    var description: String
    var duration: String
    var isFavourite: Bool = false
}
