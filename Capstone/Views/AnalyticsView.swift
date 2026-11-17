import SwiftUI

struct AnalyticsView: View {

    @ObservedObject var viewModel: ExpenseViewModel

    var currentMonthExpenses: [Expense] {
        viewModel.expenses.filter {
            Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: .month)
        }
    }

    var categoryTotals: [String: Double] {
        Dictionary(grouping: currentMonthExpenses, by: { $0.category })
            .mapValues { expenses in
                expenses.reduce(0) { $0 + $1.amount }
            }
    }

    var highestCategory: String {
        categoryTotals.max(by: { $0.value < $1.value })?.key ?? "None"
    }

    var budgetProgress: Double {
        guard viewModel.monthlyBudget > 0 else {
            return 0
        }

        return min(
            currentMonthExpenses.reduce(0) { $0 + $1.amount }
                / viewModel.monthlyBudget,
            1
        )
    }

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(alignment: .leading, spacing: 22) {

                    Text("Monthly Overview")
                        .font(.title2)
                        .fontWeight(.bold)

                    VStack(alignment: .leading, spacing: 10) {

                        Text("Total Spent This Month")
                            .foregroundColor(.white.opacity(0.8))

                        Text("₹\(currentMonthExpenses.reduce(0) { $0 + $1.amount }, specifier: "%.2f")")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)

                        Text("Budget: ₹\(viewModel.monthlyBudget, specifier: "%.0f")")
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.purple)
                    .cornerRadius(18)

                    VStack(alignment: .leading, spacing: 12) {

                        Text("Budget Progress")
                            .font(.headline)

                        ProgressView(value: budgetProgress)
                            .tint(.purple)

                        Text("\(Int(budgetProgress * 100))% of monthly budget used")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Text("Remaining: ₹\(viewModel.monthlyBudget - currentMonthExpenses.reduce(0) { $0 + $1.amount }, specifier: "%.2f")")
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)

                    VStack(alignment: .leading, spacing: 15) {

                        Text("Category Breakdown")
                            .font(.title2)
                            .fontWeight(.bold)

                        if categoryTotals.isEmpty {

                            Text("No expenses recorded this month.")
                                .foregroundColor(.gray)

                        } else {

                            ForEach(categoryTotals.keys.sorted(), id: \.self) { category in

                                VStack(alignment: .leading, spacing: 6) {

                                    HStack {
                                        Text(category)
                                            .fontWeight(.medium)

                                        Spacer()

                                        Text("₹\(categoryTotals[category] ?? 0, specifier: "%.2f")")
                                            .fontWeight(.semibold)
                                    }

                                    ProgressView(
                                        value: categoryTotals[category] ?? 0,
                                        total: max(
                                            currentMonthExpenses.reduce(0) { $0 + $1.amount },
                                            1
                                        )
                                    )
                                    .tint(.purple)
                                }
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {

                        Text("Highest Spending Category")
                            .font(.headline)

                        Text(highestCategory)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.purple)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.purple.opacity(0.1))
                    .cornerRadius(15)
                }
                .padding()
            }
            .navigationTitle("Analytics")
        }
    }
}