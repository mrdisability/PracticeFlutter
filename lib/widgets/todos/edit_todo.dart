import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditTodo extends StatefulWidget {
  final todoId;
  EditTodo(this.todoId);

  @override
  _EditTodoState createState() => _EditTodoState(todoId);
}

class _EditTodoState extends State<EditTodo> {
  final todoId;
  _EditTodoState(this.todoId);

  final _todoController = TextEditingController();
  var _enteredTodo = "";
  var _enteredCompleted = false;

  CollectionReference todos = FirebaseFirestore.instance.collection('todos');

  // void _sendTodo() async {
  //   FocusScope.of(context).unfocus();
  //
  //   FirebaseFirestore.instance.collection('todos').(
  //       {'todo': _enteredTodo, 'completed': false});
  //   _controller.clear();
  //
  //   Navigator.pop(context);
  // }

  Future<void> updateTodo() {
    return todos
        .doc(todoId.value)
        .update({'todo': _enteredTodo, 'completed': _enteredCompleted})
        .then((value) => print("Todo Updated"))
        .catchError((error) => print("Failed to update todo: $error"));
  }

  @override
  void initState() {
    _todoController.text = todoId.value;
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Todo"),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _todoController,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: const InputDecoration(labelText: 'Todo'),
                onChanged: (value) {
                  setState(() {
                    _enteredTodo = value;
                  });
                },
              ),
            ),
            Text(todoId.value),
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.focused)) {
                    return Colors.red;
                  }
                  return null; // Defer to the widget's default.
                }),
              ),
              onPressed: () {
                _enteredTodo.trim().isEmpty ? null : updateTodo();
              },
              child: const Text('Update'),
            )
          ],
        ),
      ),
    );
  }
}
