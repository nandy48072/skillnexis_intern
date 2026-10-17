import 'package:flutter/material.dart';
import 'router.dart'; // Import your route graph file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // ✅ Fixed: Added 'ColorScheme' before .fromSeed
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red.shade700),
        useMaterial3: true,
      ),
      // ✅ Using your centralized routes from routes.dart starting at Login
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}