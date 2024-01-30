import 'package:flutter/material.dart';

class ListPriceCalculator extends StatelessWidget {
  final Map<String, dynamic> product;

  const ListPriceCalculator({super.key, required this.product});

//calculator cost total
  @override
  Widget build(BuildContext context) {
    double total = product["quantity"] * product["price"];
    return Text("Total: \$${total.toStringAsFixed(2)}");
  }
}
