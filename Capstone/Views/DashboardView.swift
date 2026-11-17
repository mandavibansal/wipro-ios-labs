import SwiftUI

struct DashboardView: View {

    @ObservedObject var viewModel: ExpenseViewModel
    @State private var showAddExpense = false
    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(alignment: .leading, spacing: 20) {

                    Text("SpendWise")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Welcome back!")
                        .foregroundColor(.gray)
                    Button {
                        showAddExpense = true
                    } label: {
                        Label("Add New Expense", systemImage: "plus.circle.fill")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple.opacity(0.12))
                            .foregroundColor(.purple)
                            .cornerRadius(12)
                    }
                    .sheet(isPresented: $showAddExpense) {
                        AddExpenseView(viewModel: viewModel)
                    }
                    VStack(alignment: .leading, spacing: 12) {

                        Text("Total Expenses")
                            .foregroundColor(.white.opacity(0.8))

                        Text("₹\(viewModel.totalExpenses, specifier: "%.2f")")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)

                        Divider()
                            .overlay(.white.opacity(0.5))

                        Text("Monthly Budget: ₹\(viewModel.monthlyBudget, specifier: "%.0f")")
                            .foregroundColor(.white)

                        Text("Remaining: ₹\(viewModel.remainingBudget, specifier: "%.2f")")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.purple)
                    .cornerRadius(20)

                    Text("Recent Transactions")
                        .font(.title2)
                        .fontWeight(.bold)

                    if viewModel.expenses.isEmpty {

                        Text("No expenses yet. Start tracking!")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                            .padding()

                    } else {

                        ForEach(viewModel.expenses.suffix(5).reversed()) { expense in

                            HStack {

                                VStack(alignment: .leading) {
                                    Text(expense.title)
                                        .fontWeight(.semibold)

                                    Text(expense.category)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }

                                Spacer()

                                Text("₹\(expense.amount, specifier: "%.2f")")
                                    .fontWeight(.semibold)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}