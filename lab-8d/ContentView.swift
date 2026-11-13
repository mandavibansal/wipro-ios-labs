
import SwiftUI

struct ContentView: View {

    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var message = ""

    @State private var selectedEvent = "Tech Fest"
    @State private var acceptedTerms = false

    @State private var showSuccess = false

    let events = [
        "Tech Fest",
        "Coding Workshop",
        "Photography Workshop",
        "Cultural Night",
        "Entrepreneurship Meet"
    ]

    var isEmailValid: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return email.range(
            of: emailFormat,
            options: .regularExpression
        ) != nil
    }

    var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        isEmailValid &&
        !phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        acceptedTerms
    }

    var body: some View {

        NavigationStack {
            Form {

                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Join Our Event!")
                            .font(.title)
                            .fontWeight(.bold)

                        Text("Fill in your details to register.")
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 8)
                }

                Section(header: Text("Personal Details")) {

                    TextField("Full Name", text: $name)
                        .textContentType(.name)
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled()

                    TextField("Email Address", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()

                    if !email.isEmpty && !isEmailValid {
                        Text("Please enter a valid email address.")
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    TextField("Phone Number", text: $phone)
                        .keyboardType(.phonePad)
                }

                Section(header: Text("Event Details")) {

                    Picker("Select Event", selection: $selectedEvent) {
                        ForEach(events, id: \.self) { event in
                            Text(event).tag(event)
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Additional Message")

                        TextField(
                            "Tell us something (optional)",
                            text: $message,
                            axis: .vertical
                        )
                        .lineLimit(2...5)
                    }
                    .padding(.vertical, 5)
                }

                Section(header: Text("Confirmation")) {

                    Toggle(
                        "I agree to the terms and conditions",
                        isOn: $acceptedTerms
                    )

                    if !acceptedTerms {
                        Text("Please accept the terms to continue.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                Section {

                    Button(action: {
                        showSuccess = true
                    }) {
                        HStack {
                            Spacer()
                            Text("Register Now")
                                .fontWeight(.bold)
                            Spacer()
                        }
                    }
                    .disabled(!isFormValid)
                }
            }
            .navigationTitle("Event Registration")
            .alert("Registration Successful!", isPresented: $showSuccess) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Thank you, \(name)! You have registered for \(selectedEvent).")
            }
        }
    }
}

#Preview {
    ContentView()
}

