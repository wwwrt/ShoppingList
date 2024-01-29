import 'package:flutter/material.dart';
import 'screens/homepage.dart';

void main() {
  runApp(ShoppingListApp());
}

class ShoppingListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Cumparaturi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
