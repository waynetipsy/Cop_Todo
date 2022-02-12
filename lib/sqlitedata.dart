import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


 class Todo{
   final int? id;
   final String title;
  final String description;
  final DateTime createdTime;

   Todo({this.id, 
   required this.title,
   required this.description,
    required this.createdTime,
  });

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
   id: json['id'],
   title: json['title'],
   description: json['description'],
   createdTime: DateTime.parse(json['CreatedTime'] ),
   );

   Map<String, dynamic> toMap() => {
     'id' : id,
     'title' : title,
     'description' : description,
     'createdTime': createdTime.toIso8601String(),
  };
 }
 class DatabaseHelper {
   DatabaseHelper._privateConstructor();
   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

   static Database? _database;
   Future<Database> get database async => _database ??= await _intiDatabase();

   Future<Database> _intiDatabase() async {
     Directory documentsDirectory = await getApplicationDocumentsDirectory();
     String path = join(documentsDirectory.path, 'todo.db');
     return await openDatabase(
      path, 
      version: 1,
      onCreate: _onCreate,
     );
   }

  Future _onCreate(Database db, int verson) async {
    await db.execute('''
   CREATE TABLE todos(
     id INTERGER PRIMARY KEY,
     name TEXT
   )
   ''');
  }

 Future<List<Todo>> getTodos() async {
   Database db = await instance.database;
   var todos = await db.query('todos', orderBy: 'name');
   List<Todo> todolist = todos.isNotEmpty
      ? todos.map((e) => Todo.fromMap(e)).toList() : [];
      return todolist;
 }

 }