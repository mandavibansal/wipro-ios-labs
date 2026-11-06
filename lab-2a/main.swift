
import Foundation

func calculateMean(numbers: [Double]) -> Double {
    if numbers.isEmpty {
        return 0
    }

    let total = numbers.reduce(0, +)
    return total / Double(numbers.count)
}

func findMaximum(numbers: [Int]) -> Int? {
    return numbers.max()
}

func validateEmail(email: String) -> Bool {
    let parts = email.split(separator: "@")

    if parts.count != 2 {
        return false
    }

    return parts[1].contains(".")
        && !parts[1].hasPrefix(".")
        && !parts[1].hasSuffix(".")
}

func formatName(name: String) -> String {
    return name
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .split(separator: " ")
        .map { $0.capitalized }
        .joined(separator: " ")
}

struct Transaction {
    var title: String
    var category: String
    var amount: Double
    var isExpense: Bool
}

func calculateExpenses(transactions: [Transaction]) -> Double {
    let expenses = transactions.filter { $0.isExpense }

    let amounts = expenses.map { $0.amount }

    return amounts.reduce(0, +)
}

struct Student {
    var name: String
    var marks: Int
}

func sortStudents(students: [Student]) -> [Student] {
    return students.sorted {
        if $0.marks == $1.marks {
            return $0.name < $1.name
        }

        return $0.marks > $1.marks
    }
}

func calculateExpensesUsingLoop(transactions: [Transaction]) -> Double {
    var total = 0.0

    for transaction in transactions {
        if transaction.isExpense {
            total += transaction.amount
        }
    }

    return total
}

func categoryReport(transactions: [Transaction]) -> [String: Double] {
    let expenses = transactions.filter { $0.isExpense }

    let report = expenses.reduce(into: [String: Double]()) {
        result, transaction in

        result[transaction.category, default: 0] += transaction.amount
    }

    return report
}

print(" BASIC FUNCTIONS")

let numbers = [10.0, 20.0, 30.0, 40.0]

print("Mean:", calculateMean(numbers: numbers))
print("Maximum:", findMaximum(numbers: [12, 45, 23, 67, 34]) ?? 0)
print("Valid Email:", validateEmail(email: "student@gmail.com"))
print("Display Name:", formatName(name: "  rahul sharma  "))

print("\n TRANSACTIONS ")

let transactions = [
    Transaction(title: "Lunch", category: "Food", amount: 200, isExpense: true),
    Transaction(title: "Bus", category: "Travel", amount: 100, isExpense: true),
    Transaction(title: "Salary", category: "Income", amount: 5000, isExpense: false),
    Transaction(title: "Dinner", category: "Food", amount: 300, isExpense: true),
    Transaction(title: "Movie", category: "Entertainment", amount: 250, isExpense: true)
]

let total = calculateExpenses(transactions: transactions)

print("Total Expenses:", total)

print("\n SORTED STUDENTS ")

let students = [
    Student(name: "Rahul", marks: 85),
    Student(name: "Aman", marks: 92),
    Student(name: "Priya", marks: 85),
    Student(name: "Riya", marks: 95)
]

let sortedStudents = sortStudents(students: students)

for student in sortedStudents {
    print("\(student.name): \(student.marks)")
}

print("\n----- LOOP VS HIGHER ORDER FUNCTIONS -----")

let loopTotal = calculateExpensesUsingLoop(transactions: transactions)
let functionTotal = calculateExpenses(transactions: transactions)

print("Total using loop:", loopTotal)
print("Total using filter, map and reduce:", functionTotal)

print("\n CATEGORY WISE SPENDING ")

let report = categoryReport(transactions: transactions)

for category in report.keys.sorted() {
    print("\(category): \(report[category] ?? 0)")
}

print("\nTEST RESULTS ")

print("Function              | Result")

print("Mean                  | \(calculateMean(numbers: [10, 20, 30]))")
print("Maximum               | \(findMaximum(numbers: [10, 50, 30]) ?? 0)")
print("Email Validation      | \(validateEmail(email: "test@gmail.com"))")
print("Name Formatting       | \(formatName(name: "  riya sharma "))")
print("Total Expenses        | \(calculateExpenses(transactions: transactions))")
