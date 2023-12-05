import 'package:flutter/material.dart';
import 'package:ex2/ProductPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.network(
              "https://static.vecteezy.com/system/resources/thumbnails/016/701/258/small/shop-mart-logo-design-gradient-icon-vector.jpg",
              width: 100,
            ),
            const Icon(Icons.shopping_cart),
            const Text("Cham Cham shop"),
          ],
        ),
      ),
      body: Column(
        children: [
          Image.network(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSemqJG6yMnpMcDRjY8kq2tApVhH5LsLQpYoA&usqp=CAU",
            width: 500,
            height: 300,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(),
                ),
              );
            },
            child: const Text("Shop Now"),
          ),
        ],
      ),
    );
  }
}
