import 'package:flutter/material.dart';

class D2 extends StatefulWidget {
  const D2({super.key});

  @override
  State<D2> createState() => _D2State();
}

class _D2State extends State<D2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("page 2"),
      ),
    );
  }
}
