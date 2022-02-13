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
import '../custom_page_route.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   final tabs = [
     Container(),
     Container(),
   ];

  int selectedIndex = 0;

  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('todos');

  List<Color> myColors = [
    Colors.yellowAccent.shade100,
    Colors.red.shade100,
    Colors.blue.shade100,
    Colors.deepPurple.shade100,
    Colors.green.shade100,
    Colors.white,
    Colors.orange.shade100,
  ];

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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.green,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
           selectedIndex = index;
        }),

         items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'Todos'
          ),
        BottomNavigationBarItem(
            icon: Icon(Icons.done, size: 28,),
            label: 'Completed'
          ),
        ],
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
            colors: [Colors.grey.shade600, Colors.white]
             ),
            ),
        child: FutureBuilder<QuerySnapshot>(
        future: ref.orderBy('created').get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, index) {
                    Random random = Random();
                    Color bg = myColors[random.nextInt(7)];
                    Map data = snapshot.data!.docs[index].data() as Map;
                    DateTime mydateTime = data['created'].toDate();
                    String formattedTime =
                        DateFormat.yMMMd().add_jm().format(mydateTime);
                    return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(
                          CustomPageRoute(
                            child: ViewNote(
                              data,
                              formattedTime,
                              snapshot.data!.docs[index].reference,
                            ),
                          ),
                        )
                            .then((value) {
                          setState(() {});
                        });
                      },
                      child: Card(
                        color: bg,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${data['title']}',
                                style: GoogleFonts.lato(
                                  fontSize: 27.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  formattedTime,
                                  style: GoogleFonts.lato(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
              } else {
            return Column(
              children: const [
                Center(
                  child:  CircularProgressIndicator(
                    value: 0.6,
                    backgroundColor: Colors.green,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    strokeWidth: 8,
                  ),
                  ),
                  SizedBox(height: 20),
                Text('Loading...')
              ],
            );
          }
         },
       ),
      )
     );
    }
  }

