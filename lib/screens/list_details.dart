import 'package:flutter/material.dart';
import 'favourite_list.dart';
import '../models/shopping_list';

class ListDetails extends StatefulWidget {
  final String listName;
  final List<ShoppingList> shoppingLists;

  ListDetails({required this.listName, required this.shoppingLists});

  @override
  _ListDetailsState createState() => _ListDetailsState();
}

class _ListDetailsState extends State<ListDetails> {
  List<Map<String, dynamic>> products = [];

  void _deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  double _calculateTotalCost() {
    return products.fold(0.0, (total, product) {
      return total + (product["quantity"] * product["price"]);
    });
  }

  void _addNewProduct() {
    TextEditingController nameController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Adaugă Produs"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nume produs'),
              ),
              TextField(
                controller: quantityController,
                decoration: InputDecoration(labelText: 'Cantitate'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Preț per bucată'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Anulare"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Adaugă"),
              onPressed: () {
                setState(() {
                  products.add({
                    "name": nameController.text,
                    "quantity": double.tryParse(quantityController.text) ?? 0,
                    "price": double.tryParse(priceController.text) ?? 0,
                  });
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editProduct(int index) {
    String productName = products[index]["name"];
    double quantity = products[index]["quantity"];
    double price = products[index]["price"];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Editează Produsul"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  productName = value;
                },
                decoration: InputDecoration(labelText: "Nume Produs"),
                controller: TextEditingController(text: productName),
              ),
              TextField(
                onChanged: (value) {
                  quantity = double.tryParse(value) ?? 0.0;
                },
                decoration: InputDecoration(labelText: "Cantitate"),
                controller: TextEditingController(text: quantity.toString()),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                onChanged: (value) {
                  price = double.tryParse(value) ?? 0.0;
                },
                decoration: InputDecoration(labelText: "Preț"),
                controller: TextEditingController(text: price.toString()),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Salvează"),
              onPressed: () {
                setState(() {
                  products[index] = {
                    "name": productName,
                    "quantity": quantity,
                    "price": price
                  };
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTotalCostBox() {
    return Positioned(
      bottom: 120,
      left: 80,
      right: 80,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          "Total: \$${_calculateTotalCost()}",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
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

  Widget _buildList() {
    if (products.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Începe prin a adăuga primul produs!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0, color: Colors.grey[600]),
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          var product = products[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => _editProduct(index),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteProduct(index),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[100],
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text(
                          product["name"],
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  padding: EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text(
                    "${product["quantity"]} buc",
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  padding: EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text(
                    "\$${product["price"]}",
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
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
                    favouriteLists: widget.shoppingLists
                        .where((list) => list.isFavourite)
                        .toList(),
                    onFavouriteChanged: (ShoppingList list) {
                      // Aici poți adăuga orice logică ai nevoie, sau lasă gol dacă nu este necesar
                      print("Favoritul a fost schimbat");
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ); // Aceasta este acolada care lipsea
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
            widget.listName,
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
          _buildList(),
          _buildTotalCostBox(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewProduct,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }
}
