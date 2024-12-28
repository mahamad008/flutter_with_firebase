import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  // Sign Up Function
  Future<void> SignUp({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Sign Up Failed';
    } catch (e) {
      throw 'An unknown error occurred during Sign Up';
    }
  }

  // Sign In Function
  Future<void> SignIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Sign In Failed';
    } catch (e) {
      throw 'An unknown error occurred during Sign In';
    }
  }
}
