# Mini Project (W2): Student Management System[cite: 2]

import csv
import os

FILENAME = "students.csv"

def initialize_file():
    # Create CSV file with headers if it doesn't exist
    if not os.path.exists(FILENAME):
        with open(FILENAME, mode='w', newline='', encoding='utf-8') as file:
            writer = csv.writer(file)
            writer.writerow(["Roll Number", "Name", "Marks"])

def search_student_quiet(roll_no):
    if not os.path.exists(FILENAME):
        return False
    with open(FILENAME, mode='r', encoding='utf-8') as file:
        reader = csv.reader(file)
        next(reader, None)  # Skip header
        for row in reader:
            if row and row[0] == roll_no:
                return row
    return False

def add_student():
    roll_no = input("Enter Roll Number: ")
    
    if search_student_quiet(roll_no):
        print("Error: A student with this roll number already exists!")
        return

    name = input("Enter Name: ")
    marks = input("Enter Marks: ")

    with open(FILENAME, mode='a', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        writer.writerow([roll_no, name, marks])
    print("Student data added and saved permanently to file.")

def search_student():
    roll_no = input("Enter Roll Number to search: ")
    row = search_student_quiet(roll_no)
    if row:
        print(f"\nStudent Found -> Roll No: {row[0]}, Name: {row[1]}, Marks: {row[2]}")
    else:
        print("Student not found.")

def delete_student():
    roll_no = input("Enter Roll Number to delete: ")
    if not os.path.exists(FILENAME):
        print("No student records found.")
        return

    rows = []
    found = False
    with open(FILENAME, mode='r', encoding='utf-8') as file:
        reader = csv.reader(file)
        header = next(reader, None)
        if header:
            rows.append(header)
        for row in reader:
            if row and row[0] == roll_no:
                found = True
            else:
                rows.append(row)

    if found:
        with open(FILENAME, mode='w', newline='', encoding='utf-8') as file:
            writer = csv.writer(file)
            writer.writerows(rows)
        print(f"Student with Roll Number {roll_no} deleted and changes saved permanently.")
    else:
        print("Student not found.")

def view_students():
    if not os.path.exists(FILENAME):
        print("No student records found.")
        return
    with open(FILENAME, mode='r', encoding='utf-8') as file:
        reader = csv.reader(file)
        print("\n--- All Student Records ---")
        for row in reader:
            print(f"{row[0]}\t|\t{row[1]}\t|\t{row[2]}")

def main():
    initialize_file()
    while True:
        print("\n=== Student Management System ===")
        print("1. Add Student")
        print("2. Search Student")
        print("3. Delete Student")
        print("4. View All Students")
        print("5. Exit")
        
        choice = input("Enter your choice (1-5): ")
        
        if choice == '1':
            add_student()
        elif choice == '2':
            search_student()
        elif choice == '3':
            delete_student()
        elif choice == '4':
            view_students()
        elif choice == '5':
            print("Exiting Student Management System.")
            break
        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    main()