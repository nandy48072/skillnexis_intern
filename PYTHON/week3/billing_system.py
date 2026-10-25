class Product:
    def __init__(self, name, price, quantity):
        self.name = name
        self.price = price
        self.quantity = quantity

    @property
    def total_price(self):
        return self.price * self.quantity

class Bill:
    def __init__(self, tax_rate=5.0):
        self.products = []
        self.tax_rate = tax_rate

    def add_product(self, product):
        self.products.append(product)

    def generate_bill(self):
        if not self.products:
            print("No items added to the bill.")
            return

        subtotal = sum(p.total_price for p in self.products)
        tax_amount = (subtotal * self.tax_rate) / 100.0
        grand_total = subtotal + tax_amount

        print("\n=================================================")
        print("                 TAX INVOICE                     ")
        print("=================================================")
        print(f"{'Item Name':<15} | {'Price':<8} | {'Qty':<8} | {'Total':<10}")
        print("-" * 49)
        for p in self.products:
            print(f"{p.name:<15} | {p.price:<8.2f} | {p.quantity:<8} | {p.total_price:<10.2f}")
        print("-" * 49)
        print(f"Subtotal:                            ₹{subtotal:.2f}")
        print(f"Tax ({self.tax_rate}%):                         ₹{tax_amount:.2f}")
        print("=================================================")
        print(f"Grand Total:                         ₹{grand_total:.2f}")
        print("=================================================")

if __name__ == "__main__":
    try:
        tax = float(input("Enter applicable Tax Rate (e.g., 5 for 5%): "))
    except ValueError:
        tax = 5.0
        print("Invalid input. Defaulting tax rate to 5%.")

    bill = Bill(tax_rate=tax)

    while True:
        name = input("\nEnter Product Name: ").strip()
        if not name:
            print("Name cannot be empty.")
            continue

        while True:
            try:
                price = float(input("Enter Unit Price: "))
                if price < 0:
                    print("Price cannot be negative.")
                    continue
                break
            except ValueError:
                print("Invalid number format. Try again.")

        while True:
            try:
                qty = int(input("Enter Quantity: "))
                if qty < 0:
                    print("Quantity cannot be negative.")
                    continue
                break
            except ValueError:
                print("Invalid number format. Try again.")

        bill.add_product(Product(name, price, qty))

        cont = input("Do you want to add another product? (y/n): ").strip().lower()
        if cont != 'y':
            break

    bill.generate_bill()