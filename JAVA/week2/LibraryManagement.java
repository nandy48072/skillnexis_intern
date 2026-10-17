import java.util.ArrayList;
import java.util.List;

abstract class LibraryItem {
    private String title;
    private String author;

    public LibraryItem(String title, String author) {
        this.title = title;
        this.author = author;
    }

    public String getTitle() { return title; }
    public String getAuthor() { return author; }

    // Abstract method to demonstrate abstraction
    public abstract void displayDetails();
}

class Book extends LibraryItem {
    private boolean isBorrowed;

    public Book(String title, String author) {
        super(title, author); // Inheritance from LibraryItem
        this.isBorrowed = false;
    }

    public boolean isBorrowed() { return isBorrowed; }
    public void setBorrowed(boolean borrowed) { isBorrowed = borrowed; }

    @Override
    public void displayDetails() {
        System.out.println("Book: " + getTitle() + " | Author: " + getAuthor() + " | Borrowed: " + isBorrowed);
    }
}

class User {
    private String name;
    private int userId;

    public User(String name, int userId) {
        this.name = name;
        this.userId = userId;
    }

    public String getName() { return name; }
    public int getUserId() { return userId; }
}



class Library {
    private List<Book> books = new ArrayList<>();

    // Add Book method[cite: 12]
    public void addBook(Book book) {
        books.add(book);
        System.out.println("Added to library: " + book.getTitle());
    }

    // Borrow Book method[cite: 12]
    public void borrowBook(String title) {
        for (Book book : books) {
            if (book.getTitle().equalsIgnoreCase(title)) {
                if (!book.isBorrowed()) {
                    book.setBorrowed(true);
                    System.out.println("Success: You have borrowed '" + title + "'.");
                } else {
                    System.out.println("Error: '" + title + "' is already borrowed.");
                }
                return;
            }
        }
        System.out.println("Error: Book '" + title + "' not found in library.");
    }

    // Return Book method[cite: 12]
    public void returnBook(String title) {
        for (Book book : books) {
            if (book.getTitle().equalsIgnoreCase(title)) {
                if (book.isBorrowed()) {
                    book.setBorrowed(false);
                    System.out.println("Success: You have returned '" + title + "'.");
                } else {
                    System.out.println("Error: This book was not checked out.");
                }
                return;
            }
        }
        System.out.println("Error: Book '" + title + "' not found in library.");
    }

    public void displayCatalog() {
        System.out.println("\n--- Current Library Catalog ---");
        for (Book book : books) {
            book.displayDetails();
        }
    }
}
public class LibraryManagement {
    public static void main(String[] args) {
        System.out.println("=== Library Management System (Mini Project) ===\n");

        Library library = new Library();
        User user = new User("Alice", 101);

        Book book1 = new Book("Object Oriented Programming", "B. Stroustrup");
        Book book2 = new Book("Clean Code", "Robert C. Martin");

        // 1. Add Books[cite: 12]
        System.out.println("--- Add Books ---");
        library.addBook(book1);
        library.addBook(book2);
        library.displayCatalog();

        // 2. Borrow Books[cite: 12]
        System.out.println("\n--- Borrow Book ---");
        library.borrowBook("Clean Code");
        library.borrowBook("Clean Code"); // Test trying to borrow an already borrowed book

        // 3. Return Books[cite: 12]
        System.out.println("\n--- Return Book ---");
        library.returnBook("Clean Code");

        // Final view
        library.displayCatalog();
    }
}