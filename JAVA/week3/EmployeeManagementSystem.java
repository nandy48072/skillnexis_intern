import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

class Employee {
    private int id;
    private String name;
    private String department;
    private double salary;

    public Employee(int id, String name, String department, double salary) {
        this.id = id;
        this.name = name;
        this.department = department;
        this.salary = salary;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public String getDepartment() { return department; }
    public double getSalary() { return salary; }

    @Override
    public String toString() {
        return id + "," + name + "," + department + "," + salary;
    }

    public static Employee fromString(String line) {
        String[] parts = line.split(",");
        if (parts.length == 4) {
            try {
                int id = Integer.parseInt(parts[0].trim());
                String name = parts[1].trim();
                String dept = parts[2].trim();
                double salary = Double.parseDouble(parts[3].trim());
                return new Employee(id, name, dept, salary);
            } catch (NumberFormatException e) {
                return null;
            }
        }
        return null;
    }
}

public class EmployeeManagementSystem {
    private static final String FILE_NAME = "employees.txt";
    private static List<Employee> employees = new ArrayList<>();
    private static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        loadFromFile();
        int choice = 0;

        do {
            System.out.println("\n=== Employee Management System ===");
            System.out.println("1. Add Employee");
            System.out.println("2. Display All Employees");
            System.out.println("3. Save & Exit");
            System.out.print("Enter your choice: ");

            try {
                choice = Integer.parseInt(scanner.nextLine());
                switch (choice) {
                    case 1:
                        addEmployee();
                        break;
                    case 2:
                        displayEmployees();
                        break;
                    case 3:
                        saveToFile();
                        System.out.println("Data saved successfully. Exiting program.");
                        break;
                    default:
                        System.out.println("Invalid choice! Please enter a number between 1 and 3.");
                }
            } catch (NumberFormatException e) {
                System.out.println("Exception: Please enter a valid integer for the menu choice.");
            }
        } while (choice != 3);
    }

    private static void addEmployee() {
        try {
            System.out.print("Enter Employee ID: ");
            int id = Integer.parseInt(scanner.nextLine());

            System.out.print("Enter Employee Name: ");
            String name = scanner.nextLine().trim();
            if (name.isEmpty()) {
                System.out.println("Error: Name cannot be empty.");
                return;
            }

            System.out.print("Enter Department: ");
            String department = scanner.nextLine().trim();

            System.out.print("Enter Salary: ");
            double salary = Double.parseDouble(scanner.nextLine());
            if (salary < 0) {
                System.out.println("Error: Salary cannot be negative.");
                return;
            }

            employees.add(new Employee(id, name, department, salary));
            System.out.println("Employee added successfully!");
        } catch (NumberFormatException e) {
            System.out.println("Exception: Invalid numeric input provided for ID or Salary.");
        }
    }

    private static void displayEmployees() {
        if (employees.isEmpty()) {
            System.out.println("No records found.");
            return;
        }
        System.out.println("\n--- Employee Records ---");
        System.out.printf("%-5s | %-15s | %-15s | %-10s%n", "ID", "Name", "Department", "Salary");
        System.out.println("-----------------------------------------------------");
        for (Employee emp : employees) {
            System.out.printf("%-5d | %-15s | %-15s | %-10.2f%n", 
                emp.getId(), emp.getName(), emp.getDepartment(), emp.getSalary());
        }
    }

    private static void saveToFile() {
        try (PrintWriter writer = new PrintWriter(new FileWriter(FILE_NAME))) {
            for (Employee emp : employees) {
                writer.println(emp.toString());
            }
        } catch (IOException e) {
            System.out.println("Error saving file: " + e.getMessage());
        }
    }

    private static void loadFromFile() {
        File file = new File(FILE_NAME);
        if (!file.exists()) return;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            employees.clear();
            while ((line = reader.readLine()) != null) {
                Employee emp = Employee.fromString(line);
                if (emp != null) {
                    employees.add(emp);
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading file: " + e.getMessage());
        }
    }
}