import 'package:flutter/material.dart';
import 'favourite_list.dart';
import '../models/shopping_list';

// Definirea clasei pentru ecranul cu detalii ale listei de cumpărături
class ListDetails extends StatefulWidget {
  final String listName;
  final List<ShoppingList> shoppingLists;

// Constructor pentru inițializarea listei de cumpărături și numele acesteia
  const ListDetails(
      {super.key, required this.listName, required this.shoppingLists});

  @override
  _ListDetailsState createState() => _ListDetailsState();
}

class _ListDetailsState extends State<ListDetails> {
  // Lista de produse adăugate în lista de cumpărături
  List<Map<String, dynamic>> products = [];

// Funcția pentru ștergerea unui produs din listă
  void _deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  // Funcția pentru calcularea costului total al produselor din listă
  double _calculateTotalCost() {
    return products.fold(0.0, (total, product) {
      return total + (product["quantity"] * product["price"]);
    });
  }

  // Funcția pentru adăugarea unui produs nou în listă
  void _addNewProduct() {
    TextEditingController nameController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    // Afișarea dialogului pentru adăugarea unui produs nou
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Adaugă Produs"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Denumire produs'),
              ),
              TextField(
                controller: quantityController,
                decoration:
                    const InputDecoration(labelText: 'Unități / Kilograme'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: priceController,
                decoration:
                    const InputDecoration(labelText: 'Preț per unitate / Kg'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Anulare"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Adaugă"),
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

// Funcția pentru editarea unui produs existent
  void _editProduct(int index) {
    String productName = products[index]["name"];
    double quantity = products[index]["quantity"];
    double price = products[index]["price"];

// Afișarea dialogului pentru editarea produsului
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Editează Produsul"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  productName = value;
                },
                decoration: const InputDecoration(labelText: "Nume Produs"),
                controller: TextEditingController(text: productName),
              ),
              TextField(
                onChanged: (value) {
                  quantity = double.tryParse(value) ?? 0.0;
                },
                decoration: const InputDecoration(labelText: "Cantitate"),
                controller: TextEditingController(text: quantity.toString()),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                onChanged: (value) {
                  price = double.tryParse(value) ?? 0.0;
                },
                decoration: const InputDecoration(labelText: "Preț"),
                controller: TextEditingController(text: price.toString()),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Salvează"),
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

  // Widget pentru afișarea costului total
  Widget _buildTotalCostBox() {
    return Positioned(
      bottom: 120,
      left: 80,
      right: 80,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          "Total: ${_calculateTotalCost()} Lei",
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Widget pentru afișarea fundalului dinamic
  Widget _buildDynamicBackground() {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      decoration: const BoxDecoration(
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

  // Widget pentru construirea și afișarea listei de produse
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
                        icon: const Icon(Icons.delete,
                            color: Color.fromARGB(255, 41, 113, 28)),
                        onPressed: () => _deleteProduct(index),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ]),
                        child: Text(
                          product["name"],
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: Text(
                    "${product["quantity"]}",
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 8.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: Text(
                    "${product["price"]} Lei",
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
                    favouriteLists: widget.shoppingLists
                        .where((list) => list.isFavourite)
                        .toList(),
                    onFavouriteChanged: (ShoppingList list) {
                      print("Lista favorită a fost schimbată");
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

  @override
  Widget build(BuildContext context) {
    // Construirea interfeței utilizator pentru ecranul cu detalii ale listei de cumpărături
    return Scaffold(
      // Bara de navigație superioară
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 11.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(82, 0, 0, 0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Text(
            widget.listName,
            textAlign: TextAlign.center,
            style: const TextStyle(
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
      // Corpul principal al ecranului
      body: Stack(
        children: <Widget>[
          _buildDynamicBackground(),
          _buildList(),
          _buildTotalCostBox(),
        ],
      ),
      // Butonul pentru adăugarea unui produs nou
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewProduct,
        child: const Icon(Icons.add),
        shape: CircleBorder(),
      ),
      // Poziționarea butonului
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottom navbar
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }
}
