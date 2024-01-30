import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

//construirea conținutului
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us"),
      ),
      body: Stack(
        children: [
          _buildDynamicBackground(),
          Center(
            // Centrarea conținutului
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // Reduce dimensiunea la conținutul minim necesar
                children: <Widget>[
                  const Text("Email: tpripon99@gmail.com"),
                  IconButton(
                    icon: const Icon(Icons.language),
                    onPressed: () => _launchURL(
                        "https://www.linkedin.com/in/timotei-daniel-823629181/"),
                  ),
                  IconButton(
                    icon: const Icon(Icons.facebook),
                    onPressed: () =>
                        _launchURL("https://web.facebook.com/timotei.d99"),
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera),
                    onPressed: () => _launchURL(
                        "https://www.instagram.com/timotei_daniel28/"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//widget pentru fundalul dinamic
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
