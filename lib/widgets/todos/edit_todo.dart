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

  var isChecked = false;

  final _todoController = TextEditingController();
  var _enteredTodo = "";

  CollectionReference todos = FirebaseFirestore.instance.collection('todos');

  //(todoDocs?[index].data() as dynamic)['todo']

  getTodo() {
    FirebaseFirestore.instance
        .collection('todos')
        .doc(todoId.value)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        //print('Document data: ${documentSnapshot.data()}');

        _todoController.text = (documentSnapshot.data() as dynamic)['todo'];
        isChecked = (documentSnapshot.data() as dynamic)['completed'];

        setState(() {
          isChecked = isChecked;
          _enteredTodo = _todoController.text;
        });

        print((documentSnapshot.data() as dynamic)['completed']);
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  // void _sendTodo() async {
  //   FocusScope.of(context).unfocus();
  //
  //   FirebaseFirestore.instance.collection('todos').(
  //       {'todo': _enteredTodo, 'completed': false});
  //   _controller.clear();
  //
  //   Navigator.pop(context);
  // }

  Future<void> deleteTodo() {
    return todos.doc(todoId.value).delete().then((value) {
      print("Todo Deleted");

      Navigator.pop(context);
      Navigator.pop(context);
    }).catchError((error) => print("Failed to delete todo: $error"));
  }

  Future<void> updateTodo() {
    return todos
        .doc(todoId.value)
        .update({'todo': _enteredTodo, 'completed': isChecked}).then((value) {
      getTodo();
    }).catchError((error) => print("Failed to update todo: $error"));
  }

  @override
  void initState() {
    getTodo();

    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Todo"),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
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
            Row(
              children: [
                const Text("Completed"),
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
              ],
            ),
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
                updateTodo();
              },
              child: const Text(
                'Update',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            // TextButton(
            //   style: ButtonStyle(
            //     overlayColor: MaterialStateProperty.resolveWith<Color?>(
            //         (Set<MaterialState> states) {
            //       if (states.contains(MaterialState.focused)) {
            //         return Colors.red;
            //       }
            //       return null; // Defer to the widget's default.
            //     }),
            //   ),
            //   onPressed: () => showDialog<String>(
            //     context: context,
            //     builder: (BuildContext context) => AlertDialog(
            //       title: const Text('Delete this todo?'),
            //       actions: <Widget>[
            //         TextButton(
            //           onPressed: () => Navigator.pop(context, 'Cancel'),
            //           child: const Text('Cancel'),
            //         ),
            //         TextButton(
            //           onPressed: () => deleteTodo(),
            //           child: const Text('OK'),
            //         ),
            //       ],
            //     ),
            //   ),
            //   child: const Text('Delete'),
            // ),
            IconButton(
              color: Colors.red,
              icon: const Icon(
                Icons.delete,
              ),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Delete this todo?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => deleteTodo(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
