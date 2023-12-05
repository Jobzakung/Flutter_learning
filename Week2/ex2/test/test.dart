// import 'package:flutter/material.dart';
// import 'Product.dart';

// class ShowProduct extends StatelessWidget {
  // final List<Product> cartItems;

//   ShowProduct(this.cartItems);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Shopping Cart"),
//       ),
//       body: ListView.builder(
//         itemCount: cartItems.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             leading: Image.network(
//               cartItems[index].imageUrl,
//               width: 50,
//               height: 50,
//               fit: BoxFit.cover,
//             ),
//             title: Text(cartItems[index].name),
//             subtitle: Text("Price: \$${cartItems[index].price}"),
//           );
//         },
//       ),
//     );
//   }
// }
