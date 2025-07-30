import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_app/change_notifiers/registration_controller.dart';

class AuthService {
  AuthService._();
  static final _auth = FirebaseAuth.instance;
  static User? get user => _auth.currentUser;
  static Stream<User?> get userStream => _auth.userChanges();
  static bool get isEmailVerified => _auth.currentUser?.emailVerified ?? false;

  static Future<void> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((credential) {
            credential.user?.sendEmailVerification();
            credential.user?.updateDisplayName(fullName);
          });
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  // copied from: https://firebase.google.com/docs/auth/flutter/federated-auth?hl=tr


// static Future<UserCredential> signInWithGoogle() async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();

//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication googleAuth = googleUser.authentication;

//   // Create a new credential
//   final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);

//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }


  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      throw const NoGoogleAccountChosenException();
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
     // accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await  _auth.signInWithCredential(credential);
  }



  static Future<void> resetPassword({required String email}) =>
      _auth.sendPasswordResetEmail(email: email);

  static Future<void> logout() async {
    await _auth.signOut();
   // await GoogleSignIn().signOut();
  }
}
