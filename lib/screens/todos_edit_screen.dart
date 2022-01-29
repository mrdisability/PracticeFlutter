import 'package:flutter/material.dart';
import 'package:practice_flutter/widgets/todos/new_todo.dart';
import 'package:practice_flutter/widgets/todos/todos.dart';

class TodosEditScreen extends StatefulWidget {
  const TodosEditScreen({Key? key}) : super(key: key);

  @override
  _TodosEditScreenState createState() => _TodosEditScreenState();
}

class _TodosEditScreenState extends State<TodosEditScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Todo'),
        ),
        body: const NewTodo());
  }
}
