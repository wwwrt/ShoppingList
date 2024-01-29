import 'package:flutter/material.dart';
import '../models/shopping_list';
import 'package:url_launcher/url_launcher.dart';

class FavouriteList extends StatelessWidget {
  final List<ShoppingList> favouriteLists;

  FavouriteList({required this.favouriteLists});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 11.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(95, 255, 255, 255),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Text(
            'Listele Favorite',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF014421),
              fontSize: 20,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          _buildDynamicBackground(),
          _buildContent(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildDynamicBackground() {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(163, 233, 239, 111),
            Color.fromARGB(255, 49, 139, 155)
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return ListView.builder(
      itemCount: favouriteLists.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(favouriteLists[index].title),
          leading: Icon(Icons.favorite, color: Colors.red),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.black.withOpacity(0.3),
      shape: CircularNotchedRectangle(),
      notchMargin: 9.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Adaugă aici butoane sau alte widget-uri după cum este necesar
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
