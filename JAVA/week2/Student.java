import java.io.*;
import java.util.Scanner;

class Student{
	
	private String name;
	private String totalmarks;
	private String percentage;
	
	Scanner sc=new Scanner(System.in);
	
	void get_student_info()
	{
		System.out.println("Enter your name:");
		name=sc.nextLine();
		
		System.out.println("Enter your totalmarks:");
		totalmarks=sc.nextLine();
		System.out.println("Enter your percentage:");
		percentage=sc.nextLine();
			
	}
	
	void display_student_info()
	{
		System.out.println("\n--- Student Details ---");
        System.out.println("Name: " + name);
        System.out.println("Total Marks: " + totalmarks);
        System.out.println("Percentage: " + percentage + "%");
	}
	
	public static void main(String[] args){
		
		System.out.println("Student Class Sample");
		
		Student student1= new Student();
		
		student1.get_student_info();
		
		student1.display_student_info();
		
		
	}
	
}