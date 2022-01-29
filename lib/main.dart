import 'package:flutter/material.dart';
import 'package:practice_flutter/screens/todos_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, appSnapshot) {
          return MaterialApp(
              title: 'FlutterChat',
              theme: ThemeData(
                backgroundColor: Colors.pink,
                buttonTheme: ButtonTheme.of(context).copyWith(
                  buttonColor: Colors.pink,
                  textTheme: ButtonTextTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
                    .copyWith(secondary: Colors.pink),
              ),
              home: TodosScreen());
        });
  }
}
