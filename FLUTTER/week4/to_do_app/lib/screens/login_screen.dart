import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/screens/to_do_list_screen.dart';


class LoginScreen extends StatefulWidget{

  final String title;
  const LoginScreen({super.key, required this.title});

  @override
  State<StatefulWidget> createState() =>_LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isLoginMode = true; // Tracks whether we are logging in or signing up
  String errorMessage = "";


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleAuth() async {
    String email = _emailController.text.trim();
    String passcode = _passwordController.text.trim();

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (email.isEmpty) {
      setState(() {
        errorMessage = "Email cannot be empty";
      });
      return; // Stop execution if validation fails
    }
    else if (passcode.isEmpty) {
      setState(() {
        errorMessage = "Password cannot be empty";
      });
      return;
    }
    else if (!emailRegex.hasMatch(email)) {
      setState(() {
        errorMessage = "Please enter a valid email address";
      });
      return;
    }
    else {
      setState(() {
        errorMessage = "";
      });
    }

    setState(() => _isLoading = true);

    try {
      if (_isLoginMode) {
        // Sign In existing user
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: passcode,
        );
      } else {
        // Register new user
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: passcode,
        );
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isLoginMode ? "Successfully logged in!" : "Account created successfully!"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ToDoListScreen())
      );
    }
    catch (e) {


      setState(() {

        if(e is FirebaseAuthException){
          switch(e.code){
            case 'email-already-in-use':
              errorMessage = "This email is already registered. Please login instead.";
              break;
            case 'invalid-email':
              errorMessage = "The email address is badly formatted.";
              break;
            case 'user-not-found':
            case 'invalid-credential':
              errorMessage = "No user found. "
                  "please signup";
              break;
            case 'wrong-password':
              errorMessage = "Incorrect password. Please try again.";
              break;
            case 'weak-password':
              errorMessage = "The password provided is too weak.";
              break;
            default:
              errorMessage = e.message ?? "Authentication failed";
          }

        }

      });

    }
    finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade500,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Center(
            child: Card(
              elevation: 10,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.person_2_rounded, color: Colors.red, size: 60),
                    const SizedBox(height: 20),

                    // Dynamic Header Title based on Mode
                    Text(
                      _isLoginMode ? 'Welcome back' : 'Create Account',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    // Dynamic Subtitle based on Mode
                    Text(
                      _isLoginMode ? 'Enter your firebase login credentials' : 'Register a new account to get started',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 20),

                    // Email TextField
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Enter your email',
                        hintText: 'test@example.com',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red.shade500, width: 2.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Password TextField
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Enter your password',

                        prefixIcon: Icon(Icons.password_sharp),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red.shade500, width: 2.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 1.5),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Text(errorMessage, style: TextStyle(color: Colors.red)),
                    const SizedBox(height: 20),

                    // Submit Action Button (Login / Sign Up)
                    ElevatedButton(
                      onPressed: _isLoading ? null : _handleAuth,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade500,
                        foregroundColor: Colors.white,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                      )
                          : Text(_isLoginMode ? 'Login' : 'Sign Up'),
                    ),
                    const SizedBox(height: 10),

                    // Toggle Button to switch between Login and Sign Up views
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _isLoginMode ? "Don't have an account?" : "Already have an account?",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isLoginMode = !_isLoginMode; // Toggle mode
                              errorMessage = ""; // Clear errors on switch
                            });
                          },
                          child: Text(
                            _isLoginMode ? 'Sign Up' : 'Login',
                            style: TextStyle(
                              color: Colors.red.shade500,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}