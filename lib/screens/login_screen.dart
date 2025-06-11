import 'package:firebase_auth_exseption/auth_service/auth_sevice.dart';
import 'package:firebase_auth_exseption/screens/home_screen.dart';
import 'package:firebase_auth_exseption/screens/register_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //create keys
  final _formKey = GlobalKey<FormState>();
  //TextEditingController
  final TextEditingController _userEmailContraller = TextEditingController();
  final TextEditingController _userPasswordContraller = TextEditingController();
  //is loading?
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            );
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Log In",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _userEmailContraller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter an email";
                        } else if (!RegExp(
                          r'^[^@]+@[^@]+\.[^@]+',
                        ).hasMatch(value)) {
                          return "Please enter valid email";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Enter Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _userPasswordContraller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Password";
                        } else if (value.length < 6) {
                          return "Password must be at least 6 characters long";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Enter Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreenAccent,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            await AuthSevice().loginUsingEmail(
                              userEmail: _userEmailContraller.text.trim(),
                              userPassword: _userPasswordContraller.text.trim(),
                            );

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.lightGreenAccent,
                                  content: Text(
                                    "Log in Sucseed!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(e.toString()),
                                  );
                                },
                              );
                            }
                          } finally {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                      child:
                          isLoading
                              ? CircularProgressIndicator(color: Colors.black)
                              : Text(
                                "Log in",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black87,
                                ),
                              ),
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
