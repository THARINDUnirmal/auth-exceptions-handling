import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_exseption/auth_service/auth_sevice.dart';
import 'package:firebase_auth_exseption/screens/anonymous_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? userDetails = AuthSevice().getUserDetails;
    return Scaffold(
      appBar: AppBar(title: Text("Home page")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "User Id :\n${userDetails!.uid} ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                await AuthSevice().logOutCurrentUser();

                //navigate to anonymous screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AnonymousScreen()),
                );
              },
              child: Text("LOG OUT"),
            ),
          ],
        ),
      ),
    );
  }
}
