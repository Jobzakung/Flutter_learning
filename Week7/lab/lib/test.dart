import 'package:flutter/material.dart';
import 'package:lab/d2.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class T1 extends StatefulWidget {
  const T1({Key? key}) : super(key: key);

  @override
  State<T1> createState() => _T1State();
}

class _T1State extends State<T1> {
  int selectValue = 0;
  int line = 0;
  ScrollController _scrollController = ScrollController();
  String data = "Test Data\n";

  void fetchN() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectValue = prefs.getInt("n") ?? 0;
  }

  void setN(int n) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("n", n);
  }

  @override
  void initState() {
    super.initState();
    fetchN();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("test app"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          const SizedBox(width: 80, height: 70),
          Row(
            children: [
              NumberPicker(
                  minValue: 0,
                  maxValue: 9,
                  value: selectValue,
                  onChanged: (value) {
                    setN(value);
                    setState(() => selectValue = value);
                  }),
              ElevatedButton(
                  onPressed: (() => doAlert()),
                  child: const Text("show alert")),
            ],
          ),
          Container(
            color: Colors.amber,
            width: double.infinity,
            height: 100,
            child: SingleChildScrollView(
              controller: _scrollController,

              child: Text("$data"), //FIXME:
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () => addText(), child: const Text("Add Text")),
              ElevatedButton(
                  onPressed: () => clearText(), child: Text("Clear Text")),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const D2()));
            },
            child: const Text("goto page2"),
          ),
        ],
      ),
    );
  }

  doAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(title: Text("Alert"), content: Text("Text"));
        });
  }

  addText() {
    setState(() {
      line++;
      data += "text line $selectValue\n";
    });

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  clearText() {
    data = "";
    line = 0;
    setState(() {});
  }
}
