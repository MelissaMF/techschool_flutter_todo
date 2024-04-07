import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:techschool_demo/Model/todo.dart';
import 'package:techschool_demo/todolist.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static const databaseName = 'database.db';
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initializeDatabase();
    return _database!;
  }

  initializeDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE todos (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, date TEXT, isDone INTEGER)');
    });
  }

  insertToDo(ToDoModel todo) async {
    final db = await database;
    var res = await db.insert(ToDoModel.TABLENAME, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  updateToDo(ToDoModel todo) async {
    final db = await database;
    var res = await db.update(ToDoModel.TABLENAME, todo.toMap(),
        where: 'id = ?', whereArgs: [todo.id]);
    return res;
  }

  deleteToDo(int id) async {
    final db = await database;
    db.delete(ToDoModel.TABLENAME, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<ToDoModel>> getToDos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(ToDoModel.TABLENAME);
    return List.generate(maps.length, (index) {
      return ToDoModel(
        id: maps[index]['id'],
        title: maps[index]['title'],
        description: maps[index]['description'],
        date: DateTime.parse(maps[index]['date']),
        isDone: maps[index]['isDone'] == 1,
      );
    });
  }
}
