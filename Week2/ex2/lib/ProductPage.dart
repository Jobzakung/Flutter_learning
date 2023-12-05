import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ex2/ShowProduct.dart';
import 'Product.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<Product> products = [
    Product(1, "Iphone XS Max", Random().nextInt(10) * 1000,
        "https://support.apple.com/library/APPLE/APPLECARE_ALLGEOS/SP780/SP780-iPhone-Xs-Max.jpg"),
    Product(2, "Iphone 12", Random().nextInt(10) * 1000,
        "https://mediam.istudio.store/media/catalog/product/cache/3b7e899159f673788675d87d1d929a98/i/p/iphone-11-black-002_3.jpg"),
    Product(3, "Iphone 13", Random().nextInt(10) * 1000,
        "https://media.studio7thailand.com/5959/Apple-iPhone-12-Purple-1-square_medium.jpg"),
    Product(4, "Iphone 14", Random().nextInt(10) * 1000,
        "https://d1dtruvuor2iuy.cloudfront.net/media/catalog/product/a/p/apple_iphone_13_mini_color_starlight_1_.jpg"),
    Product(5, "Iphone 15", Random().nextInt(10) * 1000,
        "https://media-cdn.bnn.in.th/234715/iPhone_14_Purple_PDP_Image_Position-1A_Purple_1.jpg"),
  ];

  List<Product> cart = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Page"),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(
              products[index].imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text("${products[index].index}. ${products[index].name}"),
            subtitle: Text("Price: \$${products[index].price}"),
            onTap: () {
              if (!products[index].tapped) {
                setState(() {
                  products[index];
                  cart.add(products[index]);
                  products[index].tapped = true;
                });
              }

              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text("${products[index].name} added to the cart"),
              //   ),
              // );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShowProduct(cart),
              ),
            );
          },
          child: Text("add to cart"),
        ),
      ),
    );
  }
}
