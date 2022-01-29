import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:practice_flutter/widgets/todos/todo_item.dart';

class Todos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('todos')
          .orderBy(
            'created',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> todoSnapshot) {
        if (todoSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final todoDocs = todoSnapshot.data?.docs;
        return ListView.builder(
          reverse: true,
          shrinkWrap: true,
          itemCount: todoDocs?.length,
          itemBuilder: (ctx, index) => TodoItem(
            (todoDocs?[index].data() as dynamic)['todo'],
            (todoDocs?[index].data() as dynamic)['completed'],
            (todoDocs?[index].data() as dynamic)['created'],
            key: ValueKey(todoDocs?[index].id),
          ),
        );
      },
    );
  }
}

//(doc.data() as dynamic)['title']
