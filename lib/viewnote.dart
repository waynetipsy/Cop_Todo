import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ViewNote extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  const ViewNote(this.data, this.time, this.ref,
   {Key? key}) : super(key: key);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  
  late String title;
  late String description;

  bool edit = false;
  GlobalKey<FormState> Key = GlobalKey<FormState>();

  void _showDialog() {
    showDialog(
      context: context, 
      builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
    title: Text('Confirm Delete',
    style: GoogleFonts.lato(
      fontWeight: FontWeight.bold,
      fontSize: 25,
      color: Colors.black,
     ),
    ), 
    content: const Text('Are you sure?'),
    actions: [
      MaterialButton(
        onPressed: delete,
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
      );
  }

  @override
  Widget build(BuildContext context) {
    title = widget.data['title'];
    description = widget.data['description'];
    return SafeArea(
      child: Scaffold(

   floatingActionButton: edit ?  FloatingActionButton(
     onPressed: save,
   child: Icon(Icons.save_rounded,
    color: Colors.black,
   ),
   backgroundColor: Colors.green,
   ) : null,
    resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 20.0,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.black,
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),

                   ElevatedButton(
                      onPressed: _showDialog,
                      child: const Icon(
                        Icons.delete,
                        size: 20.0,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.red
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 5.0,
                          ),
                        ),
                      ),
                    ),

                  ],
                ), //
                const SizedBox(
                  height: 50.0,
                ),
                Form(
                  key: Key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
    
                        decoration: InputDecoration.collapsed(
                          hintText: 'Title',
                          ),
                        style: GoogleFonts.lato(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        initialValue: widget.data['title'],
                        enabled: edit,
                        onChanged: (_val) {
                          title = _val;
                        },
                        validator: (_val) {
                          if(_val!.isEmpty) {
                            return "Can't be empty";
                          }else {
                            return null;
                          }
                        }
                      ),
                       Padding(
                         padding: const EdgeInsets.only(
                           top: 12.0,
                           bottom: 12.0,
                         ),
                         child: Text(
                            widget.time,
                            style: GoogleFonts.lato(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                       ),
                  TextFormField(
                   decoration: InputDecoration(
                   hintText: 'Description',
                   ),
                   style: GoogleFonts.lato(
                     fontSize: 20.0,
                  color: Colors.white,
                    ),
                  initialValue: widget.data['description'],
                  enabled: edit,
                  onChanged: (_val) {
                    description = _val;
                  },
                  maxLines: 16,
                  validator: (_val) {
                          if(_val!.isEmpty) {
                            return "Can't be empty";
                          }else {
                            return null;
                          }
                       }
                   ),
                   SizedBox(height: 5),
                          Center(
                   child: Padding(
               padding: const EdgeInsets.all(15),
               child: Material(
                 elevation: 5.0,
                 borderRadius: BorderRadius.circular(25.0),
                 color: Colors.grey.shade800,
                 child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(
                    35.0, 13.0, 35.0, 13.0),
                    child: 
                 Text('Edit',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  
                   onPressed: () {
                     setState(() {
                                edit = !edit;
                           });
                          },
                         ),
                       ),
                      ),
                     ),   
                   ]
                 ),
                )
               ]
             )
           ),
          )
          )
        );
  }
  void delete() async {
     await widget.ref.delete();

    Fluttertoast.showToast(
     msg: 'Todo has been deleted',
     fontSize: 18,
     gravity: ToastGravity.BOTTOM,
     backgroundColor: Colors.grey.shade300,
     textColor: Colors.white,
  );  
     Navigator.pop(context);
  
  }


  void save()async {
  if (Key.currentState!.validate()) {
    await widget.ref.update(
      {'title': title, 'description' : description}
      );
      Navigator.pop(context);

    Fluttertoast.showToast(
     msg: 'Todo has been edited',
     fontSize: 18,
     gravity: ToastGravity.BOTTOM,
     backgroundColor: Colors.grey.shade300,
     textColor: Colors.white,
     );
   }
       final prefs = await SharedPreferences.getInstance();
   final userData = json.encode(
     {
      'title': title,
      'description': description,
      'created': DateTime.now(),
   }
   );
   prefs.setString('userData', userData);
  }
}