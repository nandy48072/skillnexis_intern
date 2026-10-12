BALANCE = 1000.00
DEFAULT_PIN = "1234"

def authenticate_user():
    entered_pin = input("Enter 4-Digit PIN: ")
    return entered_pin == DEFAULT_PIN

def check_balance(balance):
    print(f"\nYour Current Balance: ${balance:.2f}\n")

def deposit(balance):
    try:
        amount = float(input("\nEnter amount to deposit: $"))
        if amount > 0:
            balance += amount
            print(f"Successfully deposited ${amount:.2f}")
            check_balance(balance)
        else:
            print("Invalid deposit amount!\n")
    except ValueError:
        print("Invalid input! Please enter numbers only.\n")
    return balance

def withdraw(balance):
    try:
        amount = float(input("\nEnter amount to withdraw: $"))
        if amount > 0:
            if amount <= balance:
                balance -= amount
                print(f"Successfully withdrew ${amount:.2f}")
                check_balance(balance)
            else:
                print("Insufficient Balance!\n")
        else:
            print("Invalid withdrawal amount!\n")
    except ValueError:
        print("Invalid input! Please enter numbers only.\n")
    return balance

def main():
    global BALANCE
    print("====================================")
    print("      WELCOME TO ATM SIMULATOR      ")
    print("====================================")

    # User Login (PIN-based)
    attempts = 0
    is_logged = False

    while attempts < 3:
        if authenticate_user():
            is_logged = True
            print("\nLogin Successful!\n")
            break
        else:
            attempts += 1
            print(f"Incorrect PIN! Attempts remaining: {3 - attempts}\n")

    if not is_logged:
        print("Card blocked due to multiple incorrect attempts.")
        return

    # ATM Options Menu
    exit_app = False
    while not exit_app:
        print("--------------- MENU ---------------")
        print("1. Check Balance")
        print("2. Deposit Money")
        print("3. Withdraw Money")
        print("4. Exit")
        option = input("Choose an option (1-4): ")

        if option == '1':
            check_balance(BALANCE)
        elif option == '2':
            BALANCE = deposit(BALANCE)
        elif option == '3':
            BALANCE = withdraw(BALANCE)
        elif option == '4':
            print("\nThank you for using our ATM. Goodbye!")
            exit_app = True
        else:
            print("Invalid Option! Please select between 1 and 4.\n")

if __name__ == "__main__":
    main()