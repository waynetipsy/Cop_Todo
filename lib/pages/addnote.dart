import 'package:firebase_auth/firebase_auth.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late String title;
  late String description;

  

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(25.0)
      ),
    backgroundColor: Colors.white,
          content: Container(
            padding: const EdgeInsets.all(15.0),
            height: 377,
          
            child: Column(
                children: [
                  Text('Add Todo Task',
               style: GoogleFonts.lato(
                 fontSize: 27,
                 fontWeight: FontWeight.bold,
                color: Colors.black,
                   ),   
                  ),
             const  SizedBox(height: 20),
               TextField(
                 maxLines: 1,
                 onChanged: (_value) {
                   title = _value;
                 },
                decoration: InputDecoration(
                  fillColor: Colors.green,
                 focusedBorder: const UnderlineInputBorder(
                   borderSide: BorderSide(color: Colors.black,
                   ),
                 ),
                 
                 labelText: 'Title',
                 labelStyle: GoogleFonts.lato(
                   color: Colors.green,
                   fontWeight: FontWeight.bold,
                   ),
                  
                ),
              ),
             const  SizedBox(height: 20.0),
                TextField(
                 maxLines: 3,
                 
                 onChanged: (_value) {
                   description = _value;
                 },
                decoration:  InputDecoration(
                 focusedBorder: const UnderlineInputBorder(
                   borderSide: BorderSide(color: Colors.black,
                   ),
                 ),
                
                 labelText: 'Description',
                 labelStyle: GoogleFonts.lato(
                   color: Colors.green,
                   fontWeight: FontWeight.bold,
                   ),
                  
                ),
              ),
             const SizedBox(height: 25),
             Padding(
               padding: const EdgeInsets.all(15),
               child: Material(
                 elevation: 5.0,
                 borderRadius: BorderRadius.circular(25.0),
                 color: Colors.black,
                 child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(
                    35.0, 13.0, 35.0, 13.0),
                    child: Text('Save Todo',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                     ),
                    ),
                   onPressed: add
                   ),
                 ),
               ),
             ],
          ),
       ),
     );    
  }

  void add() async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('todos');

    var data = {
      'title': title,
      'description': description,
      'created': DateTime.now(),
    };
    ref.add(data);
    Navigator.pop(context);

   final prefs = await SharedPreferences.getInstance();
   final userData = json.encode(
     {
      'title': title,
      'description': description,
      'created': DateTime.now(),
   }
   );
   prefs.setString('userData', userData);
    
   ScaffoldMessenger.of(context).showSnackBar( 
     const SnackBar(
    content:  Text('Todo added!'),
    duration: Duration(seconds: 3)
    ),
   );
  }
 }