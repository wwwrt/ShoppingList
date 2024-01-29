import 'package:flutter/material.dart';
import '../models/shopping_list';
import 'package:url_launcher/url_launcher.dart';

class FavouriteList extends StatefulWidget {
  final List<ShoppingList> favouriteLists;
  final Function onFavouriteChanged;

  FavouriteList(
      {Key? key,
      required this.favouriteLists,
      required this.onFavouriteChanged})
      : super(key: key);
  @override
  _FavouriteListState createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
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
          Padding(
            padding: EdgeInsets.only(
                top: 60, bottom: 10), // Ajustează valoarea după preferințe
            child: _buildContent(),
          ),
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
            Color.fromARGB(255, 49, 139, 155),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return ListView.builder(
      itemCount: widget.favouriteLists.length,
      itemBuilder: (context, index) {
        return _buildFavouriteListItem(
            context, widget.favouriteLists[index], index);
      },
    );
  }

  Widget _buildFavouriteListItem(
      BuildContext context, ShoppingList list, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          leading: Text(
            list.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Color.fromARGB(255, 46, 119, 17)),
            onPressed: () {
              _removeItemFromList(index);
            },
          ),
        ),
      ),
    );
  }

  void _removeItemFromList(int index) {
    setState(() {
      var removedList = widget.favouriteLists[index];
      widget.favouriteLists.removeAt(index);
      widget.onFavouriteChanged(removedList);
    });
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
          IconButton(
            icon: Icon(Icons.home,
                color: Color.fromARGB(255, 255, 255, 255), size: 40),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite,
                color: Color.fromARGB(255, 255, 255, 255), size: 45),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavouriteList(
                    favouriteLists: widget.favouriteLists,
                    onFavouriteChanged: (_) {}, // Dummy function
                  ),
                ),
              );
            },
          ),
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
