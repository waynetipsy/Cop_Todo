
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_todo/screen/database/database.dart';
import '../models/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_todo/pages/homepage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';


class AddNote extends StatefulWidget {
    final Todo? todo;
    final Function? updateTodoList;

    AddNote({this.todo, this.updateTodoList});


  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  String _title  = '';
  late String description;
  String btnText = 'Add Note';
  String titleText = 'Add Note';
   String? priority;
  DateTime _date = DateTime.now();
  final _formKey = GlobalKey<FormState>();
     
   TextEditingController _dateController = TextEditingController();

   final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
    List<String> priorities = ['Low ', 'Medium', 'High'];
      
      @override
   void initState() {
     super.initState();

     if(widget.todo != null) {
      _title = widget.todo!.title!;
      _date = widget.todo!.date!;
      priority = widget.todo!.priority!;

      setState(() {
        btnText = 'Update Todo';
        titleText = 'Update Todo';
      });
     }
     else {
       setState(() {
       btnText = 'Add Todo';
        titleText = 'Add Todo';   
       });
     }

     _dateController.text = _dateFormatter.format(_date);
   }
     
     @override
    void dispose() {
       _dateController.dispose();
       super.dispose();
    }

   _handleDataPicker() async {
      final DateTime? date = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2010),
        lastDate: DateTime(2100),
        builder: (context, child) => 
        Theme(
          data: ThemeData().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.green,
              surface: Colors.green,
              onPrimary: Colors.green,
              onSurface: Colors.black,
            ),
            
          ),
          child: child!,
        ),
     );
           if(date != null && date != _date) {
          setState(() {
         _date = date;
          });
       _dateController.text = _dateFormatter.format(date);
     }
   }

   _delete () {
     DatabaseHelper.instance.deleteTodo(widget.todo!.id!);
     Navigator.pushReplacement(
       context, 
       MaterialPageRoute(builder: (_) => HomePage())
       );
       widget.updateTodoList!();
   }

   _submit() {
   if(_formKey.currentState!.validate()) {
     _formKey.currentState!.save();
     print('$_title, $priority, $_date');

     Todo todo = Todo(
       title: _title, 
       date: _date,
       priority: priority,
       );

       if(widget.todo == null) {
        todo.status = 0;
        DatabaseHelper.instance.insertTodo(todo);

        Navigator.pushReplacement(
          context, MaterialPageRoute(
            builder: (_) => HomePage(),
            ),
         ); 
         }
         else{
           todo.id = widget.todo!.id;
           todo.status = widget.todo!.status;
           DatabaseHelper.instance.updateTodo(todo);

           Navigator.pushReplacement(
          context, MaterialPageRoute(
            builder: (_) => HomePage(),
            ),
           );
         }
         widget.updateTodoList!();
    }
   }

   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 40, vertical: 80.0
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomePage(),)),
                    child: Icon(Icons.arrow_back_ios,
                    size: 30.0,
                  color: Colors.black,
                    ),
                  ),
                SizedBox(height: 50.0),
                Text(titleText,
                style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.bold,
                 ),
                ),
                SizedBox(height: 20.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 18.0),
                        decoration: InputDecoration(
                          
                          labelText: 'Title',
                          labelStyle: TextStyle(
                            fontSize: 18.0 ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )
                          ),
                          validator: (input) => 
                        input!.trim().isEmpty ? 'please enter a todo title' : null,
                        onSaved: (input) => _title = input!,
                       initialValue: _title,
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 20.0),
                         child: TextFormField(
                           readOnly: true,
                           controller: _dateController,
                        style: TextStyle(fontSize: 18.0),
                        onTap: _handleDataPicker,
                        decoration: InputDecoration(
                          labelText: 'Date',
                          labelStyle: TextStyle(
                            fontSize: 18.0 ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical:20.0),
                      child: DropdownButtonFormField(
                         isDense: true,
                        icon: Icon(Icons.arrow_drop_down_circle),
                         iconSize: 22.0,
                         iconEnabledColor: Colors.green,
                        items: priorities.map((String priority) {
                        
                          return DropdownMenuItem(
                            value: priority,
                            child: Text(
                              priority,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                          );
                        }).toList(),
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        labelText: 'priorities',
                      labelStyle: TextStyle(fontSize: 18.0),
                        border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                     validator: (input) => priority == null ? 'Please select a priority level' : null, 
                      onChanged: (value) {
                          setState(() {
                            priority = value.toString();
                            print(priority);
                          });
                         },
                      value: priority,
                      ),
                    ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                   height: 60.0,  
                   width: double.infinity,
                   decoration: BoxDecoration(
                     color: Colors.green,
                    borderRadius: BorderRadius.circular(30.0)
                   ),
                  child: ElevatedButton(
                   style: ElevatedButton.styleFrom(
                     primary: Colors.green,
                   ),
                    onPressed: _submit,
                     child: Text(btnText,
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 20.0,
                          ),
                         ),
                        ),
                      ),
                    widget.todo != null ? Container(
                 margin: EdgeInsets.symmetric(vertical: 20.0),
                height: 60.0,  
                width: double.infinity, 
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  ),
                  onPressed: _delete,
                  child: Text('Delete Todo',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                      ),
                     )
                    ),
                  ): SizedBox.shrink(),
                    ],
                
                  )
                ),
              ],
            ),
          ),
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
       'title': _title,
       'description': description,
       'created': DateTime.now(),
    };
    ref.add(data);

   Fluttertoast.showToast(
     msg: 'Todo has been created',
     fontSize: 18,
     gravity: ToastGravity.BOTTOM,
     backgroundColor: Colors.grey.shade300,
     textColor: Colors.white,
     );
    Navigator.pop(context);
   }
  }