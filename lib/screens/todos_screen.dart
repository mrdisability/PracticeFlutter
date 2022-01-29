import 'package:flutter/material.dart';
import 'package:practice_flutter/widgets/todos/new_todo.dart';
import 'package:practice_flutter/widgets/todos/todos.dart';

class TodosScreen extends StatefulWidget {
  @override
  _TodosScreenState createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: const <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Create Todo'),
                    ],
                  ),
                ),
                value: 'pressed',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'pressed') {}
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Todos(),
            ),
            NewTodo(),
          ],
        ),
      ),
    );
  }
}
