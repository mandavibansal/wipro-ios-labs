import SwiftUI

struct ContentView: View {

    @State private var studentName = ""
    @State private var marks = ""
    @State private var resultMessage = ""
    @State private var errorMessage = ""

    var body: some View {

        NavigationStack {
            VStack(spacing: 20) {

                Text("Student Registration")
                    .font(.largeTitle)
                    .bold()

                TextField("Enter student name", text: $studentName)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityIdentifier("studentNameField")

                TextField("Enter marks", text: $marks)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityIdentifier("marksField")

                Button("Submit") {
                    submitForm()
                }
                .buttonStyle(.borderedProminent)
                .accessibilityIdentifier("submitButton")

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .accessibilityIdentifier("errorMessage")
                }

                if !resultMessage.isEmpty {
                    Text(resultMessage)
                        .font(.headline)
                        .foregroundColor(.green)
                        .accessibilityIdentifier("resultText")
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Student App")
        }
    }

    func submitForm() {

        errorMessage = ""
        resultMessage = ""

        let trimmedName = studentName.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !trimmedName.isEmpty else {
            errorMessage = "Please enter student name"
            return
        }

        guard let studentMarks = Double(marks),
              studentMarks >= 0,
              studentMarks <= 100 else {
            errorMessage = "Please enter valid marks (0-100)"
            return
        }

        resultMessage = "Student: \(trimmedName), Marks: \(studentMarks)"
    }
}
