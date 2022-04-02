class Todo {
  int? id;
  String? title;
  DateTime? date;
  String? priority;
  int? status;

  Todo({
    
    this.title,
    this.date,
    this.priority,
    this.status,
  });

  Todo.withId({
    this.id,
    this.title,
    this.date,
    this.priority,
    this.status,
  });

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();

    if(id != null){
      map['id'] = id;
    }

    map['title'] = title;
    map['date'] = date!.toIso8601String();
    map['priority'] = priority;
    map['status'] = status;
    return map;
  }
  factory Todo.fromMap(Map<String, dynamic> map){
    return Todo.withId(
       id: map['id'],
       title: map['title'],
       priority: map['priority'],
      status: map['status'],
    );
  }
}