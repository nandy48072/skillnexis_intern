class Book:
    def __init__(self, book_id, title, author):
        self.book_id = book_id
        self.title = title
        self.author = author
        self.is_issued = False

    def __str__(self):
        status = "Issued" if self.is_issued else "Available"
        return f"ID: {self.book_id:<8} | Title: {self.title:<22} | Author: {self.author:<15} | Status: {status}"

class Library:
    def __init__(self):
        self.books = []

    def add_book(self, book):
        self.books.append(book)
        print("Book added successfully!")

    def remove_book(self, book_id):
        for book in self.books:
            if book.book_id.lower() == book_id.lower():
                self.books.remove(book)
                print("Book removed successfully.")
                return
        print("Book ID not found.")

    def issue_book(self, book_id):
        for book in self.books:
            if book.book_id.lower() == book_id.lower():
                if not book.is_issued:
                    book.is_issued = True
                    print("Book issued successfully!")
                else:
                    print("Error: Book is already issued.")
                return
        print("Book ID not found.")

    def return_book(self, book_id):
        for book in self.books:
            if book.book_id.lower() == book_id.lower():
                if book.is_issued:
                    book.is_issued = False
                    print("Book returned successfully!")
                else:
                    print("Error: Book was not currently issued.")
                return
        print("Book ID not found.")

    def display_books(self):
        if not self.books:
            print("No books in the library catalog.")
            return
        print("\n--- Library Catalog ---")
        for book in self.books:
            print(book)

if __name__ == "__main__":
    lib = Library()
   #lib.add_book(Book("B01", "Python Programming", "Guido van Rossum"))
   # lib.add_book(Book("B02", "Clean Code", "Robert Martin"))

    choice = 0
    while choice != 6:
        print("\n=== Library Management System ===")
        print("1. Display Books")
        print("2. Add Book")
        print("3. Remove Book")
        print("4. Issue Book")
        print("5. Return Book")
        print("6. Exit")
        try:
            choice = int(input("Enter your choice: "))
            if choice == 1:
                lib.display_books()
            elif choice == 2:
                bid = input("Enter Book ID: ").strip()
                title = input("Enter Book Title: ").strip()
                author = input("Enter Author Name: ").strip()
                lib.add_book(Book(bid, title, author))
            elif choice == 3:
                bid = input("Enter Book ID to remove: ").strip()
                lib.remove_book(bid)
            elif choice == 4:
                bid = input("Enter Book ID to issue: ").strip()
                lib.issue_book(bid)
            elif choice == 5:
                bid = input("Enter Book ID to return: ").strip()
                lib.return_book(bid)
            elif choice == 6:
                print("Exiting Library System.")
            else:
                print("Invalid choice!")
        except ValueError:
            print("Exception: Please enter a valid number.")