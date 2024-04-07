import 'package:flutter/material.dart';
import 'package:techschool_demo/Model/todo.dart';
import 'package:techschool_demo/newtodo.dart';
import 'package:techschool_demo/widgets/database_helper.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

_deleteToDo(ToDoModel todo) {
  DatabaseHelper.instance.deleteToDo(todo.id!);
}

class _ToDoState extends State<ToDo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.list, color: Colors.white),
            Text('Lista de Tareas', style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder<List<ToDoModel>>(
        future: DatabaseHelper.instance.getToDos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  setState(() {
                    _deleteToDo(snapshot.data![index]);
                  });
                },
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.pink[50],
                      ),
                      child: ListTile(
                        title: Text(
                            '${snapshot.data![index].title} ${snapshot.data![index].date.toString().substring(0, 10)}'),
                        subtitle: Text(snapshot.data![index].description),
                        trailing: Checkbox(
                          value: snapshot.data![index].isDone,
                          onChanged: (value) {
                            setState(() {
                              snapshot.data![index].isDone = value!;
                              DatabaseHelper.instance
                                  .updateToDo(snapshot.data![index]);
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const NewToDo()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
