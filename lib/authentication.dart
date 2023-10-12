

import 'package:expense_tracker/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';


class Authentication extends ChangeNotifier {
 final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool vattam=false;
Future<void> signInWithGoogle(BuildContext context) async {
        final sharedprefs = await SharedPreferences.getInstance();

  vattam=true;
  notifyListeners();
    try {
      // Sign out the user before signing in with Google
      await _auth.signOut();
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;
      final AdditionalUserInfo? additionalUserInfo =
          userCredential.additionalUserInfo;
 
sharedprefs.setBool(savekey,true);
      print('Signed in with Google:');
      print('User ID: ${user?.uid}');
      print('Email: ${user?.email}');
       print('Display Name: ${user?.displayName}');
      print('Provider ID: ${additionalUserInfo?.providerId}');
      vattam=false;
      notifyListeners();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (error) {
      print('Sign in with Google failed: $error');
      // Handle the error
    }
  }

// Future<UserCredential> signInWithGoogle(BuildContext context) async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

//   // Create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );
// //  Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(builder: (context) => HomePage()),
// //       );
//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(credential);
  
// }
  
  }