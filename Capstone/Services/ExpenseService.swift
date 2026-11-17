import Foundation

class ExpenseService {

    func calculateTotal(expenses: [Expense]) -> Double {
        return expenses.reduce(0) { total, expense in
            total + expense.amount
        }
    }

    func filterExpenses(
        expenses: [Expense],
        category: String
    ) -> [Expense] {
        return expenses.filter { expense in
            expense.category == category
        }
    }

    func deleteExpense(
        expenses: inout [Expense],
        id: UUID
    ) {
        expenses.removeAll { expense in
            expense.id == id
        }
    }

    func calculateCategoryTotals(
        expenses: [Expense]
    ) -> [String: Double] {

        return Dictionary(grouping: expenses, by: { $0.category })
            .mapValues { group in
                group.reduce(0) { $0 + $1.amount }
            }
    }
}