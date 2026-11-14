import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/screens/login_screen.dart';
import 'package:to_do_app/screens/to_do_list_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the currently logged-in user from Firebase Auth
    final User? user = FirebaseAuth.instance.currentUser;
    final String userEmail = user?.email ?? 'No email available';
    final String userId = user?.uid ?? 'Unknown ID';

    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Light neutral background for contrast
      appBar: AppBar(
        elevation: 2,
        // Back icon in the leading position
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context)=>ToDoListScreen())),
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        actions: [
          // Logout icon in the top bar actions
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!context.mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(title: 'Login'),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile Header Card with Avatar & Email
            Card(
              elevation: 4,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Profile Avatar with Red Accent
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.red.shade100,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.red.shade500,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // User Email Display
                    Text(
                      userEmail,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),

                    // Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: const Text(
                        'Active Account',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Account Details Section Card
            Card(
              elevation: 3,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.fingerprint, color: Colors.red.shade500),
                      title: const Text('User ID'),
                      subtitle: Text(
                        userId,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.verified_user, color: Colors.red.shade500),
                      title: const Text('Authentication Provider'),
                      subtitle: const Text('Firebase Email / Password'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // App Information / Settings Section Card
            Card(
              elevation: 3,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.info_outline, color: Colors.red.shade500),
                      title: const Text('App Version'),
                      trailing: const Text('1.0.0', style: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Bottom Logout Action Button
            // SizedBox(
            //   width: double.infinity,
            //   height: 50,
            //   child: ElevatedButton.icon(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.red.shade500,
            //       foregroundColor: Colors.white,
            //       elevation: 4,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //     ),
            //     onPressed: () async {
            //       await FirebaseAuth.instance.signOut();
            //       if (!context.mounted) return;
            //       Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const LoginScreen(title: 'Login'),
            //         ),
            //       );
            //     },
            //     icon: const Icon(Icons.logout),
            //     label: const Text(
            //       'Log Out',
            //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}