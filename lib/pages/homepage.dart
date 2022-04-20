import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'addnote.dart';
import '../models/todo_model.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screen/database/database.dart';
import '../pages/addnote.dart';
import '../maindrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget {
    
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<List<Todo>> _todoList;

  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  
    @override
   void initState() {
     super.initState();
     _updateTodoList();
   }

  _updateTodoList() {
     _todoList =  DatabaseHelper.instance.getTodoList();
  }

  bool selected = false;
  int selectedIndex = 0;
  //late bool _isloading;

  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('todos');

  List<Color> myColors = [Colors.white];

  Widget _buildNote(Todo todo) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
     child: Column(
       children: [
         ListTile(
           title: Text(todo.title!, style: TextStyle(
             fontSize: 28.0,
             color: Colors.black,
             decoration: todo.status == 0
             ? TextDecoration.none
             : TextDecoration.lineThrough
            ),
           ),
           subtitle: Text('${_dateFormatter.format(todo.date!)} - ${todo.priority}', 
           style: TextStyle(
             fontSize: 12.0,
             color: Colors.green,
               decoration: todo.status == 0
             ? TextDecoration.none
             : TextDecoration.lineThrough
           ),
           ),
           trailing: Checkbox(
             value: todo.status == 1 ? true : false,
             onChanged: (value) {
               todo.status = value! ? 1 : 0;
               DatabaseHelper.instance.updateTodo(todo);
               _updateTodoList();
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage())
              );
             },
          activeColor: Colors.green,
           ),
           onTap: () => Navigator.push(context, MaterialPageRoute(
               builder: (_) => AddNote(
              updateTodoList: _updateTodoList(),
              todo: todo,
                 ),
               ),
             ),
          ),
         Divider(height: 5.0, color: Colors.black, thickness: 2.0),
       ],
     ),
    );
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
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => AddNote(
              updateTodoList: _updateTodoList(),
            ),));
          },
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: Colors.green,
        ),
        body: FutureBuilder(
        future: _todoList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.green,
                strokeWidth: 8.0,
              ),
            );
          }  

         final int completeTodoCount = snapshot.data!.where((Todo todo) => todo.status == 1).toList().length;

          return  ListView.builder(
           padding: EdgeInsets.symmetric(vertical: 80.0),
           
         itemCount: int.parse(snapshot.data.length.toString()) + 1,
          itemBuilder: (BuildContext context, int index){
         if(index == 0) {
           return Padding(
             padding: EdgeInsets.symmetric(
               horizontal: 40.0,
               vertical: 20.0
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Tasks',
              style: TextStyle(
                color: Colors.black,
               fontSize: 36,
               fontWeight: FontWeight.bold, 
              ),
              
              ),
              SizedBox(height: 30.0),
              Text( '$completeTodoCount of ${snapshot.data.length}',
              style: TextStyle(
                color: Colors.black,
               fontSize: 20.0,
               fontWeight: FontWeight.w600  , 
                 ),
                ),
               ],
              ),
             );
           }
           return _buildNote(snapshot.data[index - 1]);
                }
              );
             }
             ),
            );
         }
      }
           
