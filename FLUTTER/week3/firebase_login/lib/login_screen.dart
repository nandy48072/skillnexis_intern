import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget{

  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() =>_LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen>{

  final TextEditingController _email=TextEditingController();
  final TextEditingController _password=TextEditingController();
  bool _isLoading=false;

  @override
  void dispose() {

    _email.dispose();
    _password.dispose();
    super.dispose();

  }

  Future<void> _handleAuth() async {

    String email=_email.text.trim();
    String password=_password.text.trim();

    if(email.isEmpty || password.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email & password cannot be empty!'))
      );
      return;
    }

    setState(() => _isLoading = true);

    try{

        UserCredential userCredential;

        try{
          userCredential=await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
        }
        catch(e){
          userCredential= await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
        }

         String loggedInUser=userCredential.user?.email??email;
        //
        final prefs= await SharedPreferences.getInstance();
        await prefs.setString('logged_in_user', loggedInUser);

        if(!mounted) return;

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context)=>ProfileScreen(username:loggedInUser))
        );



    }
    catch(error){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString()),backgroundColor: Colors.red,)
        );
    }
    finally{
        if(mounted) {
          setState(() {
            _isLoading = false;
          });
        }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

        body:Center(
          child:Padding(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            child: Card(
              elevation: 10,
                color: Colors.green.shade50,
                child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.person_2,color: Colors.green,size: 60,),
                const SizedBox(height: 20,),
                const Text('Welcome Back', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("Login with Firebase Auth", style: TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 20),
                TextField(
                  controller: _email,
                  decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: _isLoading?null:_handleAuth,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,      // Button background color
                      foregroundColor: Colors.white,     // Text & Icon color
                    ),

                    child: _isLoading
                        ?const CircularProgressIndicator()
                        : const Text('Login /Register', style: TextStyle(fontSize: 16),)
                )

              ],
            ) ,
                ),
            )
            )
        )
    );
  }



}