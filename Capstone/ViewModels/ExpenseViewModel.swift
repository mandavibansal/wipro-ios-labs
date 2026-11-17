import Foundation
import SwiftUI
import Combine
class ExpenseViewModel: ObservableObject {

    @Published var expenses: [Expense] = []

    @Published var monthlyBudget: Double = 10000

    @Published var errorMessage: String = ""

    private let service = ExpenseService()

    var totalExpenses: Double {
        service.calculateTotal(expenses: expenses)
    }

    var remainingBudget: Double {
        monthlyBudget - totalExpenses
    }

    func addExpense(
        title: String,
        amount: Double,
        category: String,
        date: Date = Date()
    ) {

        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please enter an expense name."
            return
        }

        guard amount.isFinite && amount > 0 else {
            errorMessage = "Enter a valid amount greater than zero."
            return
        }

        let newExpense = Expense(
            title: title,
            amount: amount,
            category: category,
            date: date
        )

        expenses.append(newExpense)
        errorMessage = ""
    }

    func deleteExpense(id: UUID) {
        service.deleteExpense(expenses: &expenses, id: id)
    }

    func expensesForCategory(_ category: String) -> [Expense] {
        return service.filterExpenses(
            expenses: expenses,
            category: category
        )
    }
}