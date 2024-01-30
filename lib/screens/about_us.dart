import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

//contruirea conținutului
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About ME"),
      ),
      body: Stack(
        children: <Widget>[
          _buildDynamicBackground(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                  "Salut, sunt Timo! Sper că îți place proiectul meu!"),
            ),
          ),
        ],
      ),
    );
  }

//widget pentru funadalul dinamic
  Widget _buildDynamicBackground() {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(163, 233, 239, 111),
            Color.fromARGB(255, 49, 139, 155),
          ],
        ),
      ),
    );
  }
}
