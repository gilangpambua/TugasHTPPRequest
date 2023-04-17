import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'page_list_users.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas HTTP Request',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PageListUsers(),
    );
  }
}