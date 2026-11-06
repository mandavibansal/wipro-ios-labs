import Foundation

public class BankAccount {

    private var balance: Double
    public var accountHolder: String

    public init(accountHolder: String, balance: Double) throws {

        if accountHolder.isEmpty || balance < 0 {
            throw AccountError.invalidAccount
        }

        self.accountHolder = accountHolder
        self.balance = balance
    }

    public func deposit(amount: Double) {

        if amount > 0 {
            balance += amount
            print("Deposited: \(amount)")
        } else {
            print("Invalid deposit amount")
        }
    }

    public func withdraw(amount: Double) {

        if amount <= 0 {
            print("Invalid withdrawal amount")
        } else if amount > balance {
            print("Insufficient balance")
        } else {
            balance -= amount
            print("Withdrawn: \(amount)")
        }
    }

    public func showBalance() {
        print("Account Holder: \(accountHolder)")
        print("Balance: \(balance)")
    }
}

public enum AccountError: Error {
    case invalidAccount
}

fileprivate func bankMessage() {
    print("Welcome to the bank")
}

