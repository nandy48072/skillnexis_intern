import 'package:flutter/material.dart';
import '../router.dart';


class LoginScreen extends StatefulWidget{

  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() =>_LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen>{

  final TextEditingController _usernameController=TextEditingController();
  final TextEditingController _passworController=TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passworController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(padding: EdgeInsets.all(16),
        child: Card(
          elevation: 5,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.person_2_rounded,size: 50,
                  color:  Colors.red.shade900),
                const SizedBox(height: 12,),
                const Text('Welcome to Expense Tracker',
                  style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,)
                ),
                const SizedBox(height: 12,),
                const Text(
                  "Please login to your account",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 12,),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 12,),
                TextField(
                  controller: _passworController,
                  decoration: InputDecoration(
                      labelText: 'password',
                      border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 12,),
                ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade900,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

                    ),
                    onPressed: (){

                      String username=_usernameController.text;
                      String password=_passworController.text;

                      if(username.isEmpty&& password.isEmpty)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Username and Password cannot be empty!"),
                              backgroundColor: Colors.grey,
                            ),
                          );
                        }
                      else
                        {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.home,
                          );
                        }

                    },
                    child: const Text('Login',
                        style: TextStyle(fontSize: 16)))



              ],

          ),
          ),

        ),
        ),
      ),
    );
  }



}


