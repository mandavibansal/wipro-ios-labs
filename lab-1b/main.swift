import Foundation

print("Bank Account ")

do {
    let account = try BankAccount(
        accountHolder: "Krish",
        balance: 5000
    )

    account.deposit(amount: 2000)
    account.withdraw(amount: 1000)

    account.showBalance()

    account.deposit(amount: -500)
    account.withdraw(amount: 10000)
    account.withdraw(amount: 0)

} catch {
    print("Invalid account details")
}

print("\nInvalid Account ")

do {
    let account = try BankAccount(
        accountHolder: "",
        balance: -500
    )

    account.showBalance()

} catch {
    print("Account could not be created")
}

print("\nAccess Control ")

let student = AccessDemo()
student.displayDetails()