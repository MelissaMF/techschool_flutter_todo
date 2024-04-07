class ToDoModel {
  int? id;
  String title;
  String description;
  DateTime date;
  bool isDone;
  static const String TABLENAME = 'todos';

  ToDoModel(
      {this.id,
      required this.title,
      required this.description,
      required this.date,
      this.isDone = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'isDone': isDone ? 1 : 0,
    };
  }
}
