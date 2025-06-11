import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_exseption/exceptions/auth_exceptions.dart';

class AuthSevice {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //Anonymous Log In

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

  //Log Out Current Anonymous User
  Future<void> logOutCurrentUser() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (error) {
      throw Exception(authExceptionget(error.code));
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> registerUsingEmail(String userEmail, String userPassword) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
    } on FirebaseAuthException catch (error) {
      print('FirebaseAuthException: ${error.code}');
      throw Exception(authExceptionget(error.code));
    } catch (e) {
      print('Unknown error: ${e.toString()}');
      throw Exception('An unexpected error occurred.');
    }
  }

  //log in with email
  Future<void> loginUsingEmail({
    required String userEmail,
    required String userPassword,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
    } on FirebaseAuthException catch (error) {
      throw Exception(authExceptionget(error.code));
    } catch (e) {
      print(e.toString());
    }
  }
}
