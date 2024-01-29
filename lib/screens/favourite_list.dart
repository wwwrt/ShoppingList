import 'package:flutter/material.dart';
import '../models/shopping_list';
import 'package:url_launcher/url_launcher.dart';

class FavouriteList extends StatefulWidget {
  final List<ShoppingList> favouriteLists;
  final Function onFavouriteChanged;

  const FavouriteList(
      {super.key,
      required this.favouriteLists,
      required this.onFavouriteChanged});
  @override
  _FavouriteListState createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 11.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(95, 0, 0, 0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: const Text(
            'Listele Favorite',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 20,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          _buildDynamicBackground(),
          Padding(
            padding: const EdgeInsets.only(
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

  Widget _buildContent() {
    if (widget.favouriteLists.isEmpty) {
      // Afisarea unui mesaj atunci cand lista de favorite este goala
      return Center(
        child: Text(
          "Până acum, nu ai adăugat nicio listă la favorite",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 116, 116, 116),
          ),
        ),
      );
    }

    // Construirea listei de favorite daca aceasta nu este goala
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
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete,
                color: Color.fromARGB(255, 46, 119, 17)),
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
      shape: const CircularNotchedRectangle(),
      notchMargin: 9.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home,
                color: Color.fromARGB(255, 255, 255, 255), size: 40),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite,
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
