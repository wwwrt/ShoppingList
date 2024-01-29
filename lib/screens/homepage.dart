import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'list_details.dart';
import '../models/shopping_list';
import 'favourite_list.dart';
import '../screens/about_us.dart';
import '../screens/contact_us.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ShoppingList> shoppingLists = [];

  void _addNewList(String title, Color color) {
    final newList = ShoppingList(title: title, color: color);
    setState(() {
      shoppingLists.add(newList);
    });
  }

  void _showColorPickerDialog(String title) {
    Color pickedColor = Colors.blue;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Alege o culoare'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickedColor,
              onColorChanged: (Color color) {
                pickedColor = color;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                _addNewList(title, pickedColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddListDialog() async {
    String newListTitle = '';
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adaugă o listă nouă'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(hintText: "Titlul listei"),
                  onChanged: (value) {
                    newListTitle = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Continuă'),
              onPressed: () {
                Navigator.of(context).pop();
                _showColorPickerDialog(newListTitle);
              },
            ),
          ],
        );
      },
    );
  }

  void _toggleFavourite(int index) {
    setState(() {
      shoppingLists[index].isFavourite = !shoppingLists[index].isFavourite;
    });
  }

  void _deleteList(int index) {
    setState(() {
      shoppingLists.removeAt(index);
    });
  }

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
            'Shopping List',
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddListDialog,
        tooltip: 'Adaugă Listă',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
    // Verifică dacă lista este goală
    if (shoppingLists.isEmpty) {
      // Afișează mesajul de întâmpinare
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            'Bine ai venit! Începe prin a adăuga prima ta listă de cumpărături.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF014421),
              fontSize: 20,
            ),
          ),
        ),
      );
    }

    // Dacă lista nu este goală, afișează ListView.builder ca înainte
    return ListView.builder(
      itemCount: shoppingLists.length,
      itemBuilder: (context, index) {
        final list = shoppingLists[index];

        EdgeInsets padding;
        if (index == 0) {
          // Primul element din listă va avea un padding suplimentar în partea de sus
          padding = EdgeInsets.only(top: 60, right: 20, left: 20);
        } else {
          // Celelalte elemente vor avea padding standard
          padding = EdgeInsets.only(top: 10, right: 20, left: 20);
        }

        return Padding(
          padding: padding,
          child: Card(
            color: list.color.withOpacity(0.5),
            child: ListTile(
              leading: IconButton(
                icon: Icon(
                  list.isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: Color.fromARGB(255, 19, 120, 65),
                ),
                onPressed: () => _toggleFavourite(index),
              ),
              title: Text(list.title),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.grey),
                onPressed: () => _deleteList(index),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListDetails(
                      listName: list.title,
                      shoppingLists: shoppingLists,
                    ),
                  ),
                );
              },
            ),
          ),
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
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert,
                color: Color.fromARGB(255, 255, 255, 255),
                size: 40), // Setează culoarea aici
            onSelected: _handleMenuSelection,
            itemBuilder: (BuildContext context) {
              return {
                'About Us',
                'Contact Us',
                'Instagram',
                'Facebook',
                'LinkedIn'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: TextStyle(color: Color(0xFF014421)),
                  ),
                );
              }).toList();
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
                    favouriteLists: shoppingLists
                        .where((list) => list.isFavourite)
                        .toList(),
                    onFavouriteChanged: (ShoppingList removedList) {
                      // Actualizați starea listei când o listă este eliminată din favorite
                      _toggleFavourite(shoppingLists.indexOf(removedList));
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _handleMenuSelection(String value) {
    switch (value) {
      case 'About Us':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AboutUsScreen()));
        break;
      case 'Contact Us':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ContactUsScreen()));
        break;
      case 'Instagram':
        _launchURL('https://www.instagram.com/timotei_daniel28/');
        break;
      case 'Facebook':
        _launchURL('https://web.facebook.com/timotei.d99');
        break;
      case 'LinkedIn':
        _launchURL('https://www.linkedin.com/in/timotei-daniel-823629181/');
        break;
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
