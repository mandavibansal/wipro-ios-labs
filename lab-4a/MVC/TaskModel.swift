import Foundation

struct TaskModel: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}