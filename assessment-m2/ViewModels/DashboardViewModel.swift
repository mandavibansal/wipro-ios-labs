
import Foundation

@MainActor
class DashboardViewModel: ObservableObject {

    @Published var userName = ""
    @Published var totalTasks = 0
    @Published var isLoading = false

    let service = DataService()

    func loadDashboard() async {

        isLoading = true

        async let user = service.fetchUser()
        async let tasks = service.fetchTaskInfo()

        let results = await (user, tasks)

        userName = results.0.name
        totalTasks = results.1.totalTasks

        isLoading = false
    }
}