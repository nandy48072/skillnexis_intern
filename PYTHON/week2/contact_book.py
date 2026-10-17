# Assignment 1: Contact Book using Dictionary

def contact_book():
    contacts = {}
    
    while True:
        print("\n--- Contact Book Menu ---")
        print("1. Add Contact")
        print("2. Search Contact")
        print("3. Update Contact")
        print("4. Delete Contact")
        print("5. View All Contacts")
        print("6. Exit")
        
        choice = input("Enter your choice (1-6): ")
        
        if choice == '1':
            name = input("Enter name: ")
            phone = input("Enter phone number: ")
            contacts[name] = phone
            print(f"Contact '{name}' added successfully.")
        elif choice == '2':
            name = input("Enter name to search: ")
            if name in contacts:
                print(f"Found: {name} -> {contacts[name]}")
            else:
                print(f"Contact '{name}' not found.")
        elif choice == '3':
            name = input("Enter name to update: ")
            if name in contacts:
                phone = input("Enter new phone number: ")
                contacts[name] = phone
                print(f"Contact '{name}' updated successfully.")
            else:
                print(f"Contact '{name}' not found.")
        elif choice == '4':
            name = input("Enter name to delete: ")
            if name in contacts:
                del contacts[name]
                print(f"Contact '{name}' deleted successfully.")
            else:
                print(f"Contact '{name}' not found.")
        elif choice == '5':
            print("\nAll Contacts:")
            if not contacts:
                print("No contacts available.")
            for name, phone in contacts.items():
                print(f"- {name}: {phone}")
        elif choice == '6':
            print("Exiting Contact Book.")
            break
        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    contact_book()