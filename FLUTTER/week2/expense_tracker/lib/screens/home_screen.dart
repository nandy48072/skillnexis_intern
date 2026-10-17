import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'dashboard_screen.dart';
import 'add_expense_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Dashboard loaded initially

  final List<Expense> _expenses = [];

  // 👈 Updated signature to accept 4 arguments matching AddExpenseScreen
  void _addExpense(String title, double amount, String category, DateTime date) {

    //setState() tells Flutter: "Data has changed, please redraw the screen right now."

    setState(() {
      _expenses.add(Expense(
        title: title,
        amount: amount,
        category: category,
        date: date,
      ));
      _currentIndex = 0; // Switches back to Dashboard automatically
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      DashboardScreen(expenses: _expenses),
      AddExpenseScreen(onAddExpense: _addExpense),
      HistoryScreen(expenses: _expenses),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.red.shade700,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add Expense',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_rounded),
            label: 'History',
          ),
        ],
      ),
    );
  }
}