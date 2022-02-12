import 'package:flutter/material.dart';
import 'custom_page_route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_todo/pages/login.dart';
import './google_auth.dart';


class LogOut extends StatefulWidget {
  const LogOut({ Key? key }) : super(key: key);

  @override
  _LogOutState createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
   

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      backgroundColor: Colors.white,
    title: Text('Confirm Logout',
    style: GoogleFonts.lato(
      fontWeight: FontWeight.bold,
      fontSize: 25,
      color: Colors.black,
     ),
    ), 
    content: const Text('Are you sure?'),
    actions: [
      MaterialButton(
        onPressed: () async {
      await  AuthService().signOut();
      Navigator.of(context).push(
      CustomPageRoute(child: const LoginPage(),
        ),
       );
      },
      color: Colors.green,
      child: const Text('Yes'),
      ),
      MaterialButton(onPressed: () {
        Navigator.pop(context);
      },
      color: Colors.red,
      child: const Text('Cancel'),
      ),
    ],

    );
   
   }
  }

  
