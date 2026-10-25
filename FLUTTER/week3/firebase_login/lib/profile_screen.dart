import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget{

  final String username;
  const ProfileScreen({super.key, required this.username});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();

}

class _ProfileScreenState extends State<ProfileScreen>{

  String _storedSessionUser="";

  @override
  void initState() {
    super.initState();
    _loadUserSession();
  }

  Future<void> _loadUserSession() async{
    final  prefs=await SharedPreferences.getInstance();
    setState(() {
      _storedSessionUser=prefs.getString('logged_in_user')??widget.username;
    });
  }

  //handle logout

  Future<void> _handleLogout(BuildContext context) async{

    final prefs=await SharedPreferences.getInstance();
    await prefs.remove('logged_in_user');

    await FirebaseAuth.instance.signOut();

    if(!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );


  }
  @override
  Widget build(BuildContext context) {

    // FIX: Define activeUser right away so it uses widget.username instantly
    // instead of waiting for SharedPreferences with an empty string ''.
    final activeUser = _storedSessionUser.isNotEmpty ? _storedSessionUser : widget.username;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Center(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              _storedSessionUser.isNotEmpty?_storedSessionUser:widget.username,
              style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
            ),
          ),
          const Center(
            child: Text(
              'Your profile looks nice',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          const Divider(height: 32),
          StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(activeUser)
                      .snapshots(),
                  builder: (context,snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    // ✅ CORRECT
                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return const Center(
                        child: Text('No user document found in Firebase.'),
                      );
                    }
                    var data = snapshot.data!.data() as Map<String, dynamic>?;
                    String email = data?['email'] ?? _storedSessionUser;

                    return Card(
                      color: Colors.green.shade50,
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.cloud_done, color: Colors.green),
                                SizedBox(width: 8),
                                Text(
                                  'Connected to Firebase',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text('Account Email: $email'),
                          ],
                        ),
                      ),

                    );

                  }),
          const SizedBox(height: 100,),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
            ),
            onPressed: () => _handleLogout(context),
            icon: const Icon(Icons.logout),
            label: const Text(
              'Logout',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

        ],
      ),
      )
    );

  }


}