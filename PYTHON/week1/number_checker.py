def is_even(number):
    return number % 2 == 0

def is_prime(number):
    if number <= 1:
        return False
    for i in range(2, int(number**0.5) + 1):
        if number % i == 0:
            return False
    return True

def main():
    print("=== Number Checker ===")
    num = int(input("Enter an integer number: "))

    # Check Even or Odd
    if is_even(num):
        print(f"{num} is EVEN.")
    else:
        print(f"{num} is ODD.")

    # Check Prime
    if is_prime(num):
        print(f"{num} is a PRIME number.")
    else:
        print(f"{num} is NOT a prime number.")

if __name__ == "__main__":
    main()