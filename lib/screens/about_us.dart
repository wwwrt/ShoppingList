import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About ME"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("Salut, sunt Timo! SPer că îți place proiectul meu!"),
      ),
    );
  }
}
