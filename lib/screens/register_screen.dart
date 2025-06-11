import 'package:firebase_auth_exseption/auth_service/auth_sevice.dart';
import 'package:firebase_auth_exseption/screens/home_screen.dart';
import 'package:firebase_auth_exseption/screens/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //shwo loading state
  bool isLoading = false;
  //form key
  final _formKey = GlobalKey<FormState>();

  //TextEditingControllers
  final TextEditingController _emailContraller = TextEditingController();
  final TextEditingController _passwordContraller = TextEditingController();
  final TextEditingController _comfirmPasswordContraller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Register \nThe App !",
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailContraller,
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
                        controller: _passwordContraller,
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
                      TextFormField(
                        controller: _comfirmPasswordContraller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter Password";
                          } else if (value != _passwordContraller.text) {
                            return "Password and comfirm password not match";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Comfirm Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Alrady you have an account? Sing in",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 18,
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
                              await AuthSevice().registerUsingEmail(
                                _emailContraller.text.trim(),
                                _passwordContraller.text.trim(),
                              );

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.lightGreenAccent,
                                    content: Text(
                                      "Registered !",
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
                              print(e.toString());
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
                                  "Register",
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
      ),
    );
  }
}
