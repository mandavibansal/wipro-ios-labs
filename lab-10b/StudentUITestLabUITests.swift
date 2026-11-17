import XCTest

final class StudentUITestLabUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testStudentRegistrationSuccessfully() {

        let app = XCUIApplication()
        app.launch()

        let nameField = app.textFields["studentNameField"]
        let marksField = app.textFields["marksField"]
        let submitButton = app.buttons["submitButton"]

        XCTAssertTrue(nameField.waitForExistence(timeout: 5))
        XCTAssertTrue(marksField.exists)

        nameField.tap()
        nameField.typeText("Mandavi")

        marksField.tap()
        marksField.typeText("90")

        submitButton.tap()

        let result = app.staticTexts["resultText"]

        XCTAssertTrue(result.waitForExistence(timeout: 5))
        XCTAssertEqual(
            result.label,
            "Student: Mandavi, Marks: 90.0"
        )
    }

    func testEmptyFormShowsValidationError() {

        let app = XCUIApplication()
        app.launch()

        let submitButton = app.buttons["submitButton"]

        XCTAssertTrue(submitButton.waitForExistence(timeout: 5))

        submitButton.tap()

        let errorMessage = app.staticTexts["errorMessage"]

        XCTAssertTrue(errorMessage.waitForExistence(timeout: 5))

        XCTAssertEqual(
            errorMessage.label,
            "Please enter student name"
        )
    }
}
