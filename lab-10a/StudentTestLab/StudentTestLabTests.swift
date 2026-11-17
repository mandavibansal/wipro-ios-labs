import XCTest
@testable import StudentTestLab

final class StudentTestLabTests: XCTestCase {

    func testCalculateAverageWithNormalMarks() {
        let calculator = GradeCalculator()

        let result = calculator.calculateAverage([80, 90, 100])

        XCTAssertEqual(result, 90.0)
    }

    func testCalculateAverageWithEmptyMarks() {
        let calculator = GradeCalculator()

        let result = calculator.calculateAverage([])

        XCTAssertNil(result)
    }

    func testCalculateAverageWithInvalidMarks() {
        let calculator = GradeCalculator()

        let result = calculator.calculateAverage([80, 120, 90])

        XCTAssertNil(result)
    }

    func testCalculateGradeAtBoundaryValue() {
        let calculator = GradeCalculator()

        let result = calculator.calculateGrade(90)

        XCTAssertEqual(result, "A")
    }

    func testCalculateGradeForFailingMarks() {
        let calculator = GradeCalculator()

        let result = calculator.calculateGrade(59)

        XCTAssertEqual(result, "F")
    }

    func testFormValidationWithValidDetails() {
        let validator = StudentFormValidator()

        let result = validator.isValid(
            name: "Mandavi",
            marks: [80, 90, 85]
        )

        XCTAssertTrue(result)
    }

    func testFormValidationWithEmptyName() {
        let validator = StudentFormValidator()

        let result = validator.isValid(
            name: "   ",
            marks: [80, 90]
        )

        XCTAssertFalse(result)
    }

    func testFormValidationWithInvalidMarks() {
        let validator = StudentFormValidator()

        let result = validator.isValid(
            name: "Rahul",
            marks: [80, 110]
        )

        XCTAssertFalse(result)
    }

    func testViewModelAddsStudentSuccessfully() {
        let viewModel = StudentViewModel()

        let result = viewModel.addStudent(
            name: "Aman",
            marks: [80, 90, 100]
        )

        XCTAssertTrue(result)
        XCTAssertEqual(viewModel.students.count, 1)
        XCTAssertEqual(viewModel.students[0].name, "Aman")
        XCTAssertEqual(viewModel.students[0].grade, "A")
    }

    func testViewModelDoesNotAddStudentWithInvalidDetails() {
        let viewModel = StudentViewModel()

        let result = viewModel.addStudent(
            name: "",
            marks: [80, 90]
        )

        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.students.count, 0)
    }

    func testViewModelInitializesWithSampleData() {

        let sampleStudent = Student(
            name: "Sample Student",
            marks: [80, 90],
            average: 85,
            grade: "B"
        )

        let viewModel = StudentViewModel(
            students: [sampleStudent]
        )

        XCTAssertEqual(viewModel.students.count, 1)
        XCTAssertEqual(
            viewModel.students[0].name,
            "Sample Student"
        )
    }
}