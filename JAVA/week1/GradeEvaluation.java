import java.util.Scanner;

public class GradeEvaluation {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter student marks (0-100): ");
        int marks = scanner.nextInt();

        if (marks < 0 || marks > 100) {
            System.out.println("Invalid marks entered. Please enter a value between 0 and 100.");
        } else if (marks >= 85) {
            System.out.println("Grade: A");
        } else if (marks >= 70) {
            System.out.println("Grade: B[cite: 1]");
        } else if (marks >= 50) {
            System.out.println("Grade: C[cite: 1]");
        } else {
            System.out.println("Grade: Fail[cite: 1]");
        }

        scanner.close();
    }
}