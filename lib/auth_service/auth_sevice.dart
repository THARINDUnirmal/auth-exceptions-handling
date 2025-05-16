import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_exseption/exceptions/auth_exceptions.dart';

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
    } on FirebaseAuthException catch (error) {
      print("Exception : ${authExceptionget(error.code)}");
      //throw exception
      throw Exception(authExceptionget(error.code));
    } catch (error) {
      print(error.toString());
    }
  }

  User? get getUserDetails => auth.currentUser;

  //log out current user
  Future<void> logOutCurrentUser() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (error) {
      throw Exception(authExceptionget(error.code));
    } catch (error) {
      print(error.toString());
    }
  }
}
