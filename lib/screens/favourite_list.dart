import 'package:flutter/material.dart';
import '../models/shopping_list';
import 'package:url_launcher/url_launcher.dart';

// Clasa pentru ecranul cu listele favorite
class FavouriteList extends StatefulWidget {
  final List<ShoppingList> favouriteLists;
  final Function onFavouriteChanged;

  // Constructorul clasei FavouriteList
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
    // Construiește interfața utilizator pentru lista de favorite
    return Scaffold(
      // Bara de navigație superioară
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
      // Extinde corpul sub bara de navigație
      extendBody: true,
      extendBodyBehindAppBar: true,
      // Corpul paginii
      body: Stack(
        children: <Widget>[
          _buildDynamicBackground(),
          Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 10),
            child: _buildContent(),
          ),
        ],
      ),
      //bottom navbar
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // Widget pentru fundalul dinamic
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

// Widget pentru construirea conținutului ecranului
  Widget _buildContent() {
    if (widget.favouriteLists.isEmpty) {
      // dacă lista de favorite este goala
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

    return ListView.builder(
      itemCount: widget.favouriteLists.length,
      itemBuilder: (context, index) {
        return _buildFavouriteListItem(
            context, widget.favouriteLists[index], index);
      },
    );
  }

  // Widget pentru construirea fiecărui element din lista de favorite
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

  // Funcția pentru eliminarea unui element din lista de favorite
  void _removeItemFromList(int index) {
    setState(() {
      var removedList = widget.favouriteLists[index];
      widget.favouriteLists.removeAt(index);
      widget.onFavouriteChanged(removedList);
    });
  }

  // Widget pentru bottom navbar
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

  // Funcția pentru deschiderea unui URL
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
