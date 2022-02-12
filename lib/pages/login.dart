import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../google_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter ,
          colors: [Colors.white, Colors.green]
          ),
          ),
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Image.asset('assets/todorap.png'),
       
        Align(
         alignment: Alignment.center,
         child: AnimatedTextKit(
           animatedTexts: [
             TypewriterAnimatedText('Welcome',
             textStyle: const TextStyle(fontSize: 30,
             fontWeight: FontWeight.bold,
              ),
              speed: const Duration(milliseconds: 400)
             ),
              TypewriterAnimatedText('To Your',
             textStyle: const TextStyle(fontSize: 30,
             fontWeight: FontWeight.bold,
              ),
             ),
              TypewriterAnimatedText('Todo App',
             textStyle: const TextStyle(fontSize: 30,
             fontWeight: FontWeight.bold,
              ),
             ),
            ]
           ),
          ),
        const SizedBox(height: 10),
      const  Align(alignment: Alignment.center,
        child:  Text('Login to your account to continue',
              style: TextStyle(fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              ),
             ),
            ),
        
         const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.symmetric(
           horizontal: 11,
          ),
          child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            onPrimary: Colors.green,
            minimumSize: const Size(double.maxFinite, 65),
            
          ),
            onPressed: () async {
              
              await signInWithGoogle(context);
           Column(
             children: const [
                Center(
                 child: CircularProgressIndicator(
                      value: 0.5,
                      strokeWidth: 8,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      backgroundColor: Colors.black,
                      ),
                     ),
                     SizedBox(height: 20),
                     Text('Loading...'),
             ],
           );
              },
            
           child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text('Continue With Google',
              style: GoogleFonts.lato(fontSize: 25.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
                 ),
               ),
             const SizedBox(width: 10),
          Image.asset('assets/google.png',
            height: 36.0,
                  ),
                 ],
               ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}