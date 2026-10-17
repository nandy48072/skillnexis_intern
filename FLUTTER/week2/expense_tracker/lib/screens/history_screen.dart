import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'login_screen.dart';
import 'package:expense_tracker/router.dart';

class HistoryScreen extends StatelessWidget {
  final List<Expense> expenses;

  const HistoryScreen({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense History'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              // Navigates back to the LoginScreen and clears the stack
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
          ),
        ],
      ),
      body: expenses.isEmpty
          ? const Center(
        child: Text(
          "No expenses recorded yet.",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(Icons.attach_money, color: Colors.white),
              ),
              title: Text(expense.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("${expense.date.day}/${expense.date.month}/${expense.date.year}"),
              trailing: Text(
                "\$${expense.amount.toStringAsFixed(2)}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.deepPurple),
              ),
            ),
          );
        },
      ),
    );
  }
}