import SwiftUI

struct AddExpenseView: View {

    @ObservedObject var viewModel: ExpenseViewModel

    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var amount = ""
    @State private var selectedCategory = "Food"
    @State private var selectedDate = Date()

    var body: some View {

        NavigationStack {

            Form {

                Section("Expense Details") {

                    TextField("Expense Name", text: $title)

                    TextField("Amount (₹)", text: $amount)
                        .keyboardType(.decimalPad)

                    Picker("Category", selection: $selectedCategory) {

                        ForEach(ExpenseCategory.allCases) { category in
                            Text(category.rawValue)
                                .tag(category.rawValue)
                        }
                    }

                    DatePicker(
                        "Date",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                }

                Section {

                    Button("Save Expense") {

                        guard let expenseAmount = Double(amount) else {
                            viewModel.errorMessage = "Please enter a valid amount."
                            return
                        }

                        viewModel.addExpense(
                            title: title,
                            amount: expenseAmount,
                            category: selectedCategory,
                            date: selectedDate
                        )

                        if viewModel.errorMessage.isEmpty {
                            dismiss()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .listRowBackground(Color.purple)
                }
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Invalid Input", isPresented: Binding(
                get: { !viewModel.errorMessage.isEmpty },
                set: { if !$0 { viewModel.errorMessage = "" } }
            )) {
                Button("OK", role: .cancel) {
                    viewModel.errorMessage = ""
                }
            } message: {
                Text(viewModel.errorMessage)
            }
        }
    }
}