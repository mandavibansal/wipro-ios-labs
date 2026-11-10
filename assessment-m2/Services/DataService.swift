
import Foundation

struct UserInfo {
    let name: String
}

struct TaskInfo {
    let totalTasks: Int
}

class DataService {

    func fetchUser() async -> UserInfo {
        try? await Task.sleep(for: .seconds(2))

        return UserInfo(name: "Mandavi")
    }

    func fetchTaskInfo() async -> TaskInfo {
        try? await Task.sleep(for: .seconds(2))

        return TaskInfo(totalTasks: 5)
    }
}
