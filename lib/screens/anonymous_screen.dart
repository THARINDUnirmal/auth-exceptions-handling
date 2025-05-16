import 'package:firebase_auth_exseption/auth_service/auth_sevice.dart';
import 'package:firebase_auth_exseption/screens/home_screen.dart';
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
              Center(
                child: ElevatedButton(
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
                  child: Text(
                    "Log as a anonimus!",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
