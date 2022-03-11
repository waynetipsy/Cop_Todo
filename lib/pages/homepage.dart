import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/addnote.dart';
import '../maindrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../viewnote.dart';
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool selected = false;
  int selectedIndex = 0;
  late bool _isloading;

  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('todos');

  List<Color> myColors = [Colors.white];

  @override
  void initState() {
    _isloading = true;
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isloading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Todos List',
            style: GoogleFonts.lato(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          elevation: 0.0,
          centerTitle: true,
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.black,
            child: const MainDrawer(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => const AddNote(),
            ).then((value) {
              setState(() {});
            });
          },
          child: const Icon(
            FontAwesomeIcons.plus,
            color: Colors.black,
          ),
          backgroundColor: Colors.green,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.grey.shade800, Colors.white]),
          ),
          child: FutureBuilder<QuerySnapshot>(
              future: ref.orderBy('created').get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.length == 0) {
                    return Center(
                      child: Text(
                        'You have no saved Todo!',
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const ClampingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, index) {
                        Random random = Random();
                        Color bg = myColors[random.nextInt(1)];
                        Map data = snapshot.data!.docs[index].data() as Map;
                        DateTime mydateTime = data['created'].toDate();
                        String formattedTime =
                            DateFormat.yMMMd().add_jm().format(mydateTime);
                          return InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(
                              MaterialPageRoute(
                                builder: (context) => ViewNote(
                                  data,
                                  formattedTime,
                                  snapshot.data!.docs[index].reference,
                                ),
                              ),
                            ).then((value) {
                              setState(() {});
                            });
                          },
                          child: Card(
                            color: bg,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row( 
                                children: [
                                  Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: Checkbox(
                                        value: this.selected,
                                        activeColor: Colors.green,
                                        checkColor: Colors.black,
                                        onChanged: (value) {
                                          setState(() {
                                            this.selected = this.selected;
                                          });
                                        }),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.0, horizontal: 10.0),
                                          child: Text(
                                            '${data['title']}',
                                            style: GoogleFonts.lato(
                                              fontSize: 27.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              decoration: this.selected
                                                  ? TextDecoration.lineThrough : null,
                                                
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                                 Container(
                                                 alignment: Alignment.centerRight,
                                                   child: Text(
                                                      formattedTime,
                                                      style: GoogleFonts.lato(
                                                        fontSize: 11.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.green,
                                                  decoration: this.selected ?
                                                  TextDecoration.lineThrough : null,
                                          ),
                                        ),
                                                 ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _isloading
                          ? Center(
                              child: CircularProgressIndicator(
                                value: 0.6,
                                backgroundColor: Colors.green,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                                strokeWidth: 8,
                              ),
                            )
                          : SizedBox(height: 30),
                      Text('Loading...')
                    ],
                  );
                }
              }
            ),
         ),
       );
     }
   }
