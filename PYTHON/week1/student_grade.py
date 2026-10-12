def get_grade(average):
    if average >= 90:
        return 'A+'
    elif average >= 80:
        return 'A'
    elif average >= 70:
        return 'B'
    elif average >= 60:
        return 'C'
    elif average >= 50:
        return 'D'
    else:
        return 'F (Fail)'

def main():
    print("=== Student Grade Calculator ===")
    num_subjects = int(input("Enter total number of subjects: "))
    
    total_marks = 0
    for i in range(1, num_subjects + 1):
        mark = float(input(f"Enter marks for Subject {i} (out of 100): "))
        total_marks += mark

    average = total_marks / num_subjects
    grade = get_grade(average)

    print("\n--- Summary ---")
    print(f"Total Marks: {total_marks} / {num_subjects * 100}")
    print(f"Average Marks: {average:.2f}")
    print(f"Assigned Grade: {grade}")

if __name__ == "__main__":
    main()