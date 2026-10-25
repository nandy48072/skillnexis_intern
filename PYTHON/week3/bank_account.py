class InsufficientBalanceError(Exception):
    pass

class BankAccount:
    def __init__(self, account_number, holder_name, initial_balance=0.0):
        self.account_number = account_number
        self.holder_name = holder_name
        self.__balance = initial_balance

    def deposit(self, amount):
        if amount > 0:
            self.__balance += amount
            print(f"Successfully deposited: ₹{amount}")
        else:
            print("Deposit amount must be positive.")

    def withdraw(self, amount):
        if amount > self.__balance:
            raise InsufficientBalanceError(f"Error: Insufficient balance! Current balance is ₹{self.__balance}")
        elif amount <= 0:
            print("Withdrawal amount must be positive.")
        else:
            self.__balance -= amount
            print(f"Successfully withdrew: ₹{amount}")

    def display_balance(self):
        print("\n--- Account Details ---")
        print(f"Account Number: {self.account_number}")
        print(f"Holder Name: {self.holder_name}")
        print(f"Current Balance: ₹{self.__balance}")

if __name__ == "__main__":
    acc = BankAccount("ACC1001", "Nandhini", 5000.0)
    choice = 0
    while choice != 4:
        print("\n=== Bank Account Menu ===")
        print("1. Display Balance")
        print("2. Deposit Money")
        print("3. Withdraw Money")
        print("4. Exit")
        try:
            choice = int(input("Enter your choice: "))
            if choice == 1:
                acc.display_balance()
            elif choice == 2:
                amt = float(input("Enter amount to deposit: "))
                acc.deposit(amt)
            elif choice == 3:
                amt = float(input("Enter amount to withdraw: "))
                try:
                    acc.withdraw(amt)
                except InsufficientBalanceError as e:
                    print(e)
            elif choice == 4:
                print("Exiting Bank Application.")
            else:
                print("Invalid choice!")
        except ValueError:
            print("Exception: Please enter a valid number.")