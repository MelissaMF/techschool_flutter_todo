import 'package:flutter/material.dart';
import 'package:techschool_demo/newtodo.dart';
import 'package:techschool_demo/todolist.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ToDo());
  }
}
