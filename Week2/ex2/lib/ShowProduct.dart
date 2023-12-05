import 'package:flutter/material.dart';
import 'Product.dart';

class ShowProduct extends StatelessWidget {
  final List<Product> cartItems;

  ShowProduct(this.cartItems);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Product Index: ${cartItems[0].index}"),
          Image.network(
            cartItems[0].imageUrl,
            width: 500,
            height: 500,
            fit: BoxFit.cover,
          ),
          Text("Product Name: ${cartItems[0].name}"),
          Text("Price: \$${cartItems[0].price}")
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            cartItems.clear();

            Navigator.pop(
              context,
            );
          },
          child: Text("Back"),
        ),
      ),
    );
  }
}
