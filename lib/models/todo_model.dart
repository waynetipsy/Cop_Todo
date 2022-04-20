import 'dart:convert';

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

    if(id != null) {
    map['id'] = id;
  }

    map['title'] = title;
    map['date'] = date!.toIso8601String();
    map['priority'] = priority;
    map['status'] = status;
    return map;
  }
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo.withId(
      id: map['id'],
      title: map['title'],
      date: DateTime.parse(map['date']),
      priority: map['priority'],
      status: map['status'],
    );
  }

 /*  Todo copyWith({
    int? id,
    String? title,
    DateTime? date,
    String? priority,
    int? status,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      priority: priority ?? this.priority,
      status: status ?? this.status,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, date: $date, priority: $priority, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Todo &&
      other.id == id &&
      other.title == title &&
      other.date == date &&
      other.priority == priority &&
      other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      date.hashCode ^
      priority.hashCode ^
      status.hashCode;
  } */
}
