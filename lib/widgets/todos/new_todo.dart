import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({Key? key}) : super(key: key);

  @override
  _NewTodoState createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final _controller = TextEditingController();
  var _enteredTodo = '';

  void _createTodo() async {
    FocusScope.of(context).unfocus();

    FirebaseFirestore.instance.collection('todos').add(
        {'todo': _enteredTodo, 'created': Timestamp.now(), 'completed': false});
    _controller.clear();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Todo'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(labelText: 'New todo...'),
              onChanged: (value) {
                setState(() {
                  _enteredTodo = value;
                });
              },
            ),
            // IconButton(
            //   color: Theme.of(context).primaryColor,
            //   icon: const Icon(
            //     Icons.add_rounded,
            //   ),
            //   onPressed: () => _enteredTodo.trim().isEmpty ? null : _sendTodo(),
            // )
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
                _enteredTodo.trim().isEmpty ? null : _createTodo();
              },
              child: const Text(
                'Create',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
