import SwiftUI

struct TransactionsView: View {

    @ObservedObject var viewModel: ExpenseViewModel

    @State private var searchText = ""
    @State private var selectedCategory = "All"

    var filteredExpenses: [Expense] {

        viewModel.expenses.filter { expense in

            let matchesSearch = searchText.isEmpty ||
                expense.title.localizedCaseInsensitiveContains(searchText)

            let matchesCategory = selectedCategory == "All" ||
                expense.category == selectedCategory

            return matchesSearch && matchesCategory
        }
    }

    var body: some View {

        NavigationStack {

            VStack {

                Picker("Category", selection: $selectedCategory) {
                    Text("All").tag("All")

                    ForEach(ExpenseCategory.allCases) { category in
                        Text(category.rawValue)
                            .tag(category.rawValue)
                    }
                }
                .pickerStyle(.menu)
                .padding(.horizontal)

                if filteredExpenses.isEmpty {

                    Spacer()

                    Image(systemName: "tray")
                        .font(.system(size: 45))
                        .foregroundColor(.gray)

                    Text("No transactions found")
                        .foregroundColor(.gray)
                        .padding()

                    Spacer()

                } else {

                    List {

                        ForEach(filteredExpenses) { expense in

                            HStack {

                                VStack(alignment: .leading, spacing: 5) {

                                    Text(expense.title)
                                        .fontWeight(.semibold)

                                    Text(expense.category)
                                        .font(.caption)
                                        .foregroundColor(.gray)

                                    Text(expense.date, style: .date)
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                }

                                Spacer()

                                Text("₹\(expense.amount, specifier: "%.2f")")
                                    .fontWeight(.bold)
                            }
                            .padding(.vertical, 5)
                        }
                        .onDelete { offsets in

                            let ids = offsets.map {
                                filteredExpenses[$0].id
                            }

                            for id in ids {
                                viewModel.deleteExpense(id: id)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Transactions")
            .searchable(text: $searchText, prompt: "Search expenses")
        }
    }
}