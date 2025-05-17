import 'package:firebase_auth_exseption/auth_service/auth_sevice.dart';
import 'package:firebase_auth_exseption/screens/home_screen.dart';
import 'package:firebase_auth_exseption/screens/register_screen.dart';
import 'package:flutter/material.dart';

class AnonymousScreen extends StatelessWidget {
  const AnonymousScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  shadowColor: Colors.black,
                  backgroundColor: Colors.amber,
                ),
                onPressed: () async {
                  await AuthSevice().logAsAnonymous();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.person_outline, color: Colors.black, size: 30),
                    Text(
                      "Log as a Anonymous!",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  shadowColor: Colors.black,
                  backgroundColor: Colors.amber,
                ),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.email_outlined, color: Colors.black, size: 30),
                    Text(
                      "Email Log In",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
