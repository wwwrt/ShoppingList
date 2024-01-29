import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About ME"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("Salut, sunt Timo! SPer că îți place proiectul meu!"),
      ),
    );
  }
}
