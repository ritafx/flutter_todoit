import 'package:flutter/material.dart';
import 'package:todoapp/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.indigo[300],
            accentColor: Colors.indigo[300],
            textTheme: TextTheme(
              headline1: TextStyle(
                color: Colors.indigo[300],
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ), //style for app title
              bodyText1: TextStyle(fontSize: 16.0, color: Colors.grey[900], fontWeight:FontWeight.w400), //style for not complete tasks
              bodyText2: TextStyle(fontSize: 16.0, color: Colors.grey[400], fontWeight:FontWeight.w400, decoration: TextDecoration.lineThrough), //style for complete tasks
              caption: TextStyle(fontSize: 18.0, color: Colors.grey[400], fontWeight:FontWeight.w400), //style for textfield hint text
              button: TextStyle(fontSize: 18.0, color: Colors.indigo[300], fontWeight:FontWeight.w600) //style for text button
            )
            ),
        home: Scaffold(body: Login()));
  }
}
