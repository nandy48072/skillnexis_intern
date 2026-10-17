class Expense {
  final String title;
  final double amount;
  final String category;
  final DateTime date; // 👈 1. Add this field here

  Expense({
    required this.title,
    required this.amount,
    required this.category,
    required this.date, // 👈 2. Add this to the constructor
  });
}