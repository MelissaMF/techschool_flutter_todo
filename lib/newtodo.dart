import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:techschool_demo/Model/todo.dart';
import 'package:techschool_demo/todolist.dart';
import 'package:techschool_demo/widgets/database_helper.dart';

class NewToDo extends StatefulWidget {
  const NewToDo({super.key});

  @override
  State<NewToDo> createState() => _NewToDoState();
}

class _NewToDoState extends State<NewToDo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New To Do', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.purple,
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              GestureDetector(
                onTap: () async {
                  final DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));
                  dateController.text = date.toString().substring(0, 10);
                },
                child: AbsorbPointer(
                  child: TextField(
                    controller: dateController,
                    decoration: const InputDecoration(hintText: 'Date'),
                  ),
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(hintText: 'Description'),
              ),
              ElevatedButton(
                onPressed: () {
                  DatabaseHelper.instance.insertToDo(ToDoModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      date: DateTime.parse(dateController.text)));
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              )
            ],
          ),
        ));
  }
}
