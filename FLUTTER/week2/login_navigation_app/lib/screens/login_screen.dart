import 'package:flutter/material.dart';
import 'package:login_navigation_app/screens/home_screen.dart';

class LoginScreen extends StatefulWidget{

  final String title;

  const LoginScreen({super.key,required this.title});

  @override
  State<StatefulWidget> createState() =>_LoginScreenState();



}

class _LoginScreenState extends State<LoginScreen>{

  final TextEditingController _usernameController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

   return Scaffold(

     backgroundColor: Colors.white,
     body: Center(
       child: Padding(
         padding: EdgeInsets.all(16),
         child: Card(
           elevation: 6,
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(20),
           ),
           child: Padding(padding: EdgeInsets.all(15),
           child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               const Icon(Icons.lock_person_rounded, size: 50, color: Colors.deepPurple),
               const SizedBox(height: 12),
               const Text(
                 "Welcome Back",
                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
               ),
               const SizedBox(height: 4),
               const Text(
                 "Please login to your account",
                 style: TextStyle(color: Colors.grey, fontSize: 14),
               ),
               const SizedBox(height: 24),
               TextField(
                 controller: _usernameController,
                 decoration: const InputDecoration(
                   labelText: 'Username',
                   border: OutlineInputBorder()
                 ),
               ),
               SizedBox(height: 10),
               TextField(
                 controller: _passwordController,
                 obscureText: true,
                 decoration: const InputDecoration(
                   labelText: 'Password',
                   border: OutlineInputBorder(),
                   prefixIcon: Icon(Icons.lock),
                 ),
               ),
               const SizedBox(height: 24),
               ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.deepPurple,
                   foregroundColor: Colors.white,
                   minimumSize: const Size.fromHeight(50),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10),
                   ),
                 ),
                 onPressed: () {

                   String enteredUsername = _usernameController.text;
                   String enterPassword=_passwordController.text;

                   if(enteredUsername.isNotEmpty && enterPassword.isNotEmpty){
                     Navigator.push(context,
                         MaterialPageRoute(builder: (context)=>HomeScreen(username: enteredUsername),)
                     ,);
                   }
                   else{
                     ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(
                         content: Text("Username and Password cannot be empty!"),
                         backgroundColor: Colors.red,
                         duration: Duration(seconds: 2),
                       ),
                     );
                   }
                 },
                 child: const Text('Login', style: TextStyle(fontSize: 16)),
               ),
             ],
           ),
           )
         ),
       ),
     ),

   );
  }

}

