import 'package:firebase_auth/firebase_auth.dart';

class AuthSevice {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> logAsAnonymous() async {
    try {
      final UserCredential userAuth = await auth.signInAnonymously();
      final user = userAuth.user;

      if (user != null) {
        print("User Id ==== ${user.uid}");
      } else {
        print("User is not Found!");
      }
    } catch (error) {
      print(error.toString());
    }
  }

  User? get getUserDetails => auth.currentUser;
}
