import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                        FontAwesomeIcons.backward,
                        size: 20.0,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.green,
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: delete,
                      child: const Icon(
                        Icons.delete,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.red,
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ), //
                const SizedBox(
                  height: 50.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.data['title']}',
                      style: GoogleFonts.lato(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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
             Container(
               alignment: Alignment.topLeft,
               height: MediaQuery.of(context).size.height * 0.75,
             child:Text(
              "${widget.data['description']}",
              style: GoogleFonts.lato(
              fontSize: 18.0,
              color: Colors.white,
                ),
               ),
             ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void delete() async {
     await widget.ref.delete();
     Navigator.pop(context);

  ScaffoldMessenger.of(context)
  .showSnackBar( const SnackBar(
    content:  Text('Todo has been Deleted!'),
    duration: Duration(seconds: 3)
    ),
   );
  }
}