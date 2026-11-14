  import 'package:flutter/material.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import '../constants/app_colors.dart'; // Using your app colors
  // Import your home screen or main wrapper route here
  // import '../screens/home_screen.dart';
  import '../utils/notification_service.dart';

  class LoginScreen extends StatefulWidget {
    final String title;
    const LoginScreen({super.key, required this.title});

    @override
    State<StatefulWidget> createState() => _LoginScreenState();
  }

  class _LoginScreenState extends State<LoginScreen> {
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
        return;
      } else if (passcode.isEmpty) {
        setState(() {
          errorMessage = "Password cannot be empty";
        });
        return;
      } else if (!emailRegex.hasMatch(email)) {
        setState(() {
          errorMessage = "Please enter a valid email address";
        });
        return;
      } else {
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
        // Save FCM Device Token to Firestore upon successful authentication
        await NotificationService.saveDeviceToken();

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isLoginMode ? "Successfully logged in!" : "Account created successfully!"),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );

        // Pop back or navigate to Home screen after successful auth
        Navigator.pop(context);
      } catch (e) {
        setState(() {
          if (e is FirebaseAuthException) {
            switch (e.code) {
              case 'email-already-in-use':
                errorMessage = "This email is already registered. Please login instead.";
                break;
              case 'invalid-email':
                errorMessage = "The email address is badly formatted.";
                break;
              case 'user-not-found':
              case 'invalid-credential':
                errorMessage = "No user found. Please sign up.";
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
      } finally {
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
        backgroundColor: AppColors.primary, // #2563EB primary theme background
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Center(
              child: Card(
                elevation: 10,
                color: AppColors.cardBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.lock_outline_rounded, color: AppColors.primary, size: 40),
                      ),
                      const SizedBox(height: 20),

                      // Dynamic Header Title based on Mode
                      Text(
                        _isLoginMode ? 'Welcome Back' : 'Create Account',
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Dynamic Subtitle based on Mode
                      const Text(
                        'Enter your Firebase credentials to continue',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                      ),
                      const SizedBox(height: 24),

                      // Email TextField
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Enter your email',
                          hintText: 'test@example.com',
                          prefixIcon: const Icon(Icons.email_outlined, color: AppColors.textSecondary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.primary, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Password TextField
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Enter your password',
                          prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textSecondary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.primary, width: 2),
                          ),
                        ),
                      ),

                      if (errorMessage.isNotEmpty) ...[
                        const SizedBox(height: 14),
                        Text(
                          errorMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ],

                      const SizedBox(height: 24),

                      // Submit Action Button (Login / Sign Up)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleAuth,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                              : Text(
                            _isLoginMode ? 'Login' : 'Sign Up',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Toggle Button to switch between Login and Sign Up views
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isLoginMode ? "Don't have an account?" : "Already have an account?",
                            style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
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
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
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