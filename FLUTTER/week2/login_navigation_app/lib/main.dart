import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const NavigationDemo());
}

class NavigationDemo extends StatelessWidget {
  const NavigationDemo({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.white),
      ),
      home: const LoginScreen(title: 'E-kart',),
      color: Colors.white,
    );
  }
}

