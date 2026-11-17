import Foundation

enum ExpenseCategory: String, CaseIterable, Identifiable {
    case food = "Food"
    case travel = "Travel"
    case shopping = "Shopping"
    case education = "Education"
    case entertainment = "Entertainment"
    case other = "Other"

    var id: String {
        self.rawValue
    }
}