import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../google_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  

  Future<bool> _checkInternetConnection() async {
    late bool connectStatus;
    try {
      final response = await InternetAddress.lookup('www.kindacode.com');
      if (response.isNotEmpty) {
        connectStatus = true;
      }
    } on SocketException {
      connectStatus = false;
    }
    return connectStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.grey.shade600, Colors.white]
          ),
        ),
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Image.asset('assets/todoappicon.png',
           height: 300,
           width: 300,
           ),
       
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
              TypewriterAnimatedText('To',
             textStyle: const TextStyle(fontSize: 30,
             fontWeight: FontWeight.bold,
              ),
             ),
              TypewriterAnimatedText('Cop Todo',
             textStyle: const TextStyle(fontSize: 30,
             fontWeight: FontWeight.bold,
              ),
             ),
            ]
           ),
          ),
        const SizedBox(height: 10),
       Align(alignment: Alignment.center,
        child:  Text('Login to your account to continue',
              style: GoogleFonts.lato(fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
              ),
             ),
            ),
        
         const SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.symmetric(
           horizontal: 7,
          ),
          child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            primary: Colors.black,
            onPrimary: Colors.white,
            minimumSize: const Size(double.maxFinite, 65),
            
          ),
            onPressed: () async { 
             final _internetConnection = await _checkInternetConnection();
              if (_internetConnection) {
                 await signInWithGoogle(context);
              
           SharedPreferences.getInstance().then((pref) => {
             pref.setBool('Signin', true)
           });
              }else {
                showDialog<void>(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text(
                            'Check your internet connection!',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                            ),
                          ),
                          content:  Text(
                              'Internet connection required to signin with Google.',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.lato(
                                  height: 1.5,
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                              ),
                               
                          ),
                          elevation: 30,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ]);
                    });
              }
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