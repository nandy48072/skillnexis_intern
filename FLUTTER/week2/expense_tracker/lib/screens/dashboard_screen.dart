import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../router.dart';

class DashboardScreen extends StatelessWidget{

  final List<Expense> expenses;

  const DashboardScreen({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {

    double totalSpent = expenses.fold(0, (sum, item) => sum + item.amount);

    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Dashboard'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              color: Colors.deepPurple.shade50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text("Total Spent", style: TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 8),
                    Text(
                      "\$${totalSpent.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }



}