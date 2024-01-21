import 'package:flutter/material.dart';
import 'package:json/Covert.dart';
import 'package:json/loadJson.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JSON Quiz Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Quiz>> futureQuizList;
  late int? selectedQuizIndex; // Use int?

  @override
  void initState() {
    super.initState();
    futureQuizList = loadJsonData();
    selectedQuizIndex = null; // Initialize with null
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter JSON Quiz Example'),
      ),
      body: Center(
        child: FutureBuilder<List<Quiz>>(
          future: futureQuizList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              
              List<DropdownMenuItem<int?>> dropdownItems = snapshot.data!
                  .asMap()
                  .entries
                  .map((entry) => DropdownMenuItem<int?>(
                        value: entry.key,
                        child: Text(entry.value.title),
                      ))
                  .toList();

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownButton<int?>(
                    value: selectedQuizIndex,
                    items: dropdownItems,
                    onChanged: (value) {
                      setState(() {
                        selectedQuizIndex = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  if (selectedQuizIndex != null) // Check if a quiz is selected
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Title: ${snapshot.data![selectedQuizIndex!].title}'),
                        Text('Choices:'),
                        for (var choice
                            in snapshot.data![selectedQuizIndex!].choices)
                          Text('  ${choice.title} (ID: ${choice.id})'),
                        Text(
                            'Answer ID: ${snapshot.data![selectedQuizIndex!].answerId}'),
                        SizedBox(height: 16),
                      ],
                    ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
