class Calculator:
    def add(self, a, b):
        return a + b

    def subtract(self, a, b):
        return a - b

    def multiply(self, a, b):
        return a * b

    def divide(self, a, b):
        if b == 0:
            raise ZeroDivisionError("Division by zero is not permitted.")
        return a / b

if __name__ == "__main__":
    calc = Calculator()
    choice = 0
    while choice != 5:
        print("\n=== Calculator Menu ===")
        print("1. Addition (+)")
        print("2. Subtraction (-)")
        print("3. Multiplication (*)")
        print("4. Division (/)")
        print("5. Exit")
        try:
            choice = int(input("Enter your choice: "))
            if 1 <= choice <= 4:
                num1 = float(input("Enter first number: "))
                num2 = float(input("Enter second number: "))
                
                if choice == 1:
                    print(f"Result: {calc.add(num1, num2)}")
                elif choice == 2:
                    print(f"Result: {calc.subtract(num1, num2)}")
                elif choice == 3:
                    print(f"Result: {calc.multiply(num1, num2)}")
                elif choice == 4:
                    print(f"Result: {calc.divide(num1, num2)}")
            elif choice == 5:
                print("Exiting Calculator.")
            else:
                print("Invalid choice! Please select between 1 and 5.")
        except ValueError:
            print("Exception: Please enter valid numeric values.")
        except ZeroDivisionError as e:
            print(f"Math Exception: {e}")