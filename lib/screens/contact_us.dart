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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
              onPressed: () =>
                  _launchURL("https://www.instagram.com/timotei_daniel28/"),
            ),
          ],
        ),
      ),
    );
  }
}
