
import Foundation
import SwiftUI

@MainActor
class TaskViewModel: ObservableObject {

    @Published var tasks: [TaskItem] = []

    func addTask(_ title: String) {
        let newTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !newTitle.isEmpty else { return }

        tasks.append(TaskItem(title: newTitle))
    }

    func toggleTask(_ task: TaskItem) {
        guard let index = tasks.firstIndex(
            where: { $0.id == task.id }
        ) else { return }

        tasks[index].isCompleted.toggle()
    }

    func deleteTask(_ task: TaskItem) {
        tasks.removeAll { $0.id == task.id }
    }

    var completedTasks: [TaskItem] {
        tasks.filter { $0.isCompleted }
    }

    var pendingTasks: [TaskItem] {
        tasks.filter { !$0.isCompleted }
    }
}
