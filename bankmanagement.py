# ================================================================
# Project: Bank Management System
# File: bankmanagement.py
#
# Project instructions
# --------------------
# Build a small interactive banking application using three classes:
#
# 1. Account
#    - Stores and updates the private account balance.
#    - Handles only its own balance data.
#
# 2. Customer
#    - Stores the customer's private name.
#    - Owns one Account object.
#    - Passes deposit and withdrawal requests to that account.
#
# 3. Bank
#    - Provides the interactive menu.
#    - Reads and validates all user input.
#    - Prevents negative deposits and withdrawals.
#    - Prevents withdrawals that exceed the available balance.
#
# Menu options
# ------------
# v - View customer and account details
# d - Deposit money
# w - Withdraw money
# x - Exit the application
#
# Run the project with:
# python3 bankmanagement.py
# ================================================================


class Account:
    """Stores and updates one account balance."""

    def __init__(self, balance: float = 0.0) -> None:
        self.__balance: float = balance

    @property
    def balance(self) -> float:
        """Return the balance without allowing direct modification."""
        return self.__balance

    def update(self, amount: float) -> None:
        """Update the balance using an amount approved by the Bank."""
        self.__balance += amount

    def __str__(self) -> str:
        return f"Balance: ${self.__balance:.2f}"


class Customer:
    """Stores customer data and owns one Account."""

    def __init__(self, name: str) -> None:
        self.__name: str = name
        self.__account: Account = Account()

    @property
    def balance(self) -> float:
        """Provide read-only access to the customer's account balance."""
        return self.__account.balance

    def deposit(self, amount: float) -> None:
        """Send an approved deposit to the account."""
        self.__account.update(amount)

    def withdraw(self, amount: float) -> None:
        """Send an approved withdrawal to the account."""
        self.__account.update(-amount)

    def __str__(self) -> str:
        return f"Customer: {self.__name}\n{self.__account}"


class Bank:
    """Handles the menu, input validation, and banking operations."""

    def __init__(self, customer_name: str) -> None:
        self.__customer: Customer = Customer(customer_name)

    def view(self) -> None:
        """Display the customer and current account balance."""
        print(self.__customer)

    def read_amount(self, message: str) -> float | None:
        """Read and validate a positive numeric amount."""
        raw_value: str = input(message).strip()

        try:
            amount: float = float(raw_value)
        except ValueError:
            print("Please enter a valid number.")
            return None

        if amount <= 0:
            print("The amount must be greater than zero.")
            return None

        return amount

    def deposit(self) -> None:
        """Validate and process a deposit."""
        amount: float | None = self.read_amount("Deposit amount: $")

        if amount is None:
            return

        self.__customer.deposit(amount)
        print("Deposit completed.")

    def withdraw(self) -> None:
        """Validate and process a withdrawal."""
        amount: float | None = self.read_amount("Withdrawal amount: $")

        if amount is None:
            return

        # The Bank applies the withdrawal rule before updating the account.
        if amount > self.__customer.balance:
            print("Not enough funds.")
            return

        self.__customer.withdraw(amount)
        print("Withdrawal completed.")

    def help(self) -> None:
        """Display the available menu options."""
        print("\nv - View")
        print("d - Deposit")
        print("w - Withdraw")
        print("x - Exit")

    def menu(self) -> None:
        """Run the interactive banking menu."""
        choice: str = ""

        while choice != "x":
            self.help()
            choice = input("Choice: ").strip().lower()

            match choice:
                case "v":
                    self.view()
                case "d":
                    self.deposit()
                case "w":
                    self.withdraw()
                case "x":
                    print("Goodbye.")
                case _:
                    print("Invalid choice.")


def main() -> None:
    """Create the bank application and start its menu."""
    bank: Bank = Bank("Georges")
    bank.menu()


if __name__ == "__main__":
    main()
