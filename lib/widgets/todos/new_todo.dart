import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewTodo extends StatefulWidget {
  @override
  _NewTodoState createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final _controller = TextEditingController();
  var _enteredTodo = '';

  void _sendTodo() async {
    FocusScope.of(context).unfocus();

    FirebaseFirestore.instance.collection('todos').add(
        {'todo': _enteredTodo, 'created': Timestamp.now(), 'completed': false});
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
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
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: const Icon(
              Icons.add_rounded,
            ),
            onPressed: () => _enteredTodo.trim().isEmpty ? null : _sendTodo(),
          )
        ],
      ),
    );
  }
}
