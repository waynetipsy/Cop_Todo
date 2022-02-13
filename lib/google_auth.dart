import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './pages/homepage.dart';


 class AuthService {
   
Future signOut () async {
  await GoogleSignIn().signOut();
  await FirebaseAuth.instance.signOut();
 }
 }

GoogleSignIn googleSignIn = GoogleSignIn();
final auth = FirebaseAuth.instance;
CollectionReference users =FirebaseFirestore
.instance.collection('users');

Future signInWithGoogle (BuildContext context) async {
   try {
     final  googleSignInAccount = await googleSignIn.signIn();
   
   if(googleSignInAccount != null) {
  final GoogleSignInAuthentication googleSignInAuthentication = await
    googleSignInAccount.authentication;

     final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
    );

   final UserCredential authResult = 
   await auth.signInWithCredential(credential);

   final User? user = authResult.user;
   

   var userData = {
     'name' : googleSignInAccount.displayName,
     'provider' : 'google',
     'photoUrl' : googleSignInAccount.photoUrl,
     'email' :  googleSignInAccount.email,
   };
  users.doc(user!.uid).get().then((doc) {
   if (doc.exists) {
     doc.reference.update(userData);

  Navigator.of(context).pushReplacement(
     MaterialPageRoute(
    builder: (context) => const HomePage()),
    );
    

   }else{
  users.doc(user.uid).set(userData);
Navigator.of(context).pushReplacement(
     MaterialPageRoute(
    builder: (context) => const HomePage()),
        );
       }
      }
    );
   }
   } catch (platformException) {
     // ignore: avoid_print
     print(platformException);
   }
}
