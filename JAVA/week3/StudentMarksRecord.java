import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

public class StudentMarksRecord {
    public static void main(String[] args) {
        ArrayList<Integer> marks = new ArrayList<>();
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter the number of students: ");
        int n = scanner.nextInt();

        System.out.println("Enter the marks for each student:");
        for (int i = 0; i < n; i++) {
            System.out.print("Student " + (i + 1) + ": ");
            marks.add(scanner.nextInt());
        }

        if (marks.isEmpty()) {
            System.out.println("No marks recorded.");
        } else {
            int highest = Collections.max(marks);
            int lowest = Collections.min(marks);
            
            double sum = 0;
            for (int mark : marks) {
                sum += mark;
            }
            double average = sum / marks.size();

            System.out.println("\n--- Marks Record Summary ---");
            System.out.println("All Marks: " + marks);
            System.out.println("Highest Marks: " + highest);
            System.out.println("Lowest Marks: " + lowest);
            System.out.println("Average Marks: " + average);
        }

        scanner.close();
    }
}