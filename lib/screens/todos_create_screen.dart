import 'package:flutter/material.dart';
import 'package:practice_flutter/widgets/todos/new_todo.dart';
import 'package:practice_flutter/widgets/todos/todos.dart';

class TodosCreateScreen extends StatefulWidget {
  const TodosCreateScreen({Key? key}) : super(key: key);

  @override
  _TodosCreateScreenState createState() => _TodosCreateScreenState();
}

class _TodosCreateScreenState extends State<TodosCreateScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Todo'),
        ),
        body: NewTodo());
  }
}
