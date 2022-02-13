import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_todo/pages/homepage.dart';
import 'package:login_todo/pages/onboardingscreen.dart';
  

  class AuthChange extends StatelessWidget {
    const AuthChange({ Key? key }) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return  StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ),
            ),
          ) ;
        }else if (snapShot.hasError) {
          return const Center(child: Text('Something went wrong'),);
        }else if (snapShot.hasData) {
          return const HomePage();
        }else {
          return const Onboarding();
        }
      },
    );
  }
}
