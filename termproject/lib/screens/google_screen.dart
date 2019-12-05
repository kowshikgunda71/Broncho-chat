import 'package:firebase_auth/firebase_auth.dart';
import '../screens/welcome_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool flag = false;
  GoogleSignIn googleSignIn = GoogleSignIn();
  Future<bool> loginWithGoogle() async {
    try {
      //GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) return false;
      AuthResult res =
          await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));
      if (res.user == null) return false;
      return true;
    } catch (e) {
      print("Error logging with google");
      return false;
    }
  }

  signOut() {
    googleSignIn.signOut();
    flag = true;
    print("User Signed out");
  }
}
