
import XCTest
@testable import TaskManager

@MainActor
final class TaskViewModelTests: XCTestCase {

    func testAddTask() {
        let viewModel = TaskViewModel()

        viewModel.addTask("Complete Swift Lab")

        XCTAssertEqual(viewModel.tasks.count, 1)
        XCTAssertEqual(
            viewModel.tasks.first?.title,
            "Complete Swift Lab"
        )
    }

    func testEmptyTaskIsNotAdded() {
        let viewModel = TaskViewModel()

        viewModel.addTask("   ")

        XCTAssertEqual(viewModel.tasks.count, 0)
    }

    func testToggleTask() {
        let viewModel = TaskViewModel()

        viewModel.addTask("Study Swift")

        let task = viewModel.tasks[0]
        viewModel.toggleTask(task)

        XCTAssertTrue(viewModel.tasks[0].isCompleted)
    }

    func testDeleteTask() {
        let viewModel = TaskViewModel()

        viewModel.addTask("Practice coding")

        let task = viewModel.tasks[0]
        viewModel.deleteTask(task)

        XCTAssertEqual(viewModel.tasks.count, 0)
    }

    func testPendingAndCompletedTasks() {
        let viewModel = TaskViewModel()

        viewModel.addTask("Task One")
        viewModel.addTask("Task Two")

        let firstTask = viewModel.tasks[0]
        viewModel.toggleTask(firstTask)

        XCTAssertEqual(viewModel.completedTasks.count, 1)
        XCTAssertEqual(viewModel.pendingTasks.count, 1)
    }
}
