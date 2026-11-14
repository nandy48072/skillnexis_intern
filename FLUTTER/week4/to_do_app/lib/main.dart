import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do_app/screens/to_do_list_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
           colorScheme: .fromSeed(seedColor: Colors.red.shade500),
      ),
      color: Colors.white,
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(color:Colors.red),
                ),
              );
            }
            if(snapshot.hasData){
              return ToDoListScreen();
            }
            return const LoginScreen(title: 'login');
          }),
    );
  }
}
