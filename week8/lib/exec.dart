import 'package:flutter/material.dart';
import 'package:week8/db.dart';

class DbTest2 extends StatefulWidget {
  const DbTest2({Key? key}) : super(key: key);

  @override
  State<DbTest2> createState() => _DbTest2State();
}

class _DbTest2State extends State<DbTest2> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _ratingController;
  late List<Map<String, dynamic>> _mybooks;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _authorController = TextEditingController();
    _ratingController = TextEditingController();
    _mybooks = [];
    _toGetAll();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DB Test'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _addDialog(),
                child: const Text("Add New Book"),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _mybooks.length,
              itemBuilder: (context, index) {
                final json = _mybooks[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(json['id'].toString()),
                    ),
                    title: Text(json['title']),
                    subtitle: Text(json['author']),
                    trailing: SizedBox(
                      width: 100,
                      height: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _editDialog(json),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Delete Book"),
                                      content: Text(
                                          "Are you sure you want to delete ${json['title']}?"),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text("No"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            _toDelete(json['id']);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Yes"),
                                        ),
                                      ],
                                    );
                                  });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _toAdd(Map<String, dynamic> row) async {
    final db = DB.instance;
    db.insert(row);
    _toGetAll();
  }

  void _toDelete(int id) async {
    final db = DB.instance;
    db.delete(id);
    _toGetAll();
  }

  void _toUpdate(Map<String, dynamic> row) async {
    final db = DB.instance;
    db.update(row);
    _toGetAll();
  }

  void _toGetAll() async {
    final db = DB.instance;
    final books = await db.queryAll();
    setState(() {
      _mybooks = books;
    });
  }

  void _addDialog() {
    _titleController.text = '';
    _authorController.text = '';
    _ratingController.text = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add New Book"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(hintText: "Title"),
              ),
              TextField(
                controller: _authorController,
                decoration: const InputDecoration(hintText: "Author"),
              ),
              TextField(
                controller: _ratingController,
                decoration: const InputDecoration(hintText: "Rating"),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
            ElevatedButton(
              onPressed: () {
                //check if all children are not empty
                if (_titleController.text.isEmpty ||
                    _authorController.text.isEmpty ||
                    _ratingController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Error"),
                        content: const Text("All fields are required"),
                        actions: [
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  final row = {
                    DB.columnTitle: _titleController.text,
                    DB.columnAuthor: _authorController.text,
                    DB.columnRating: double.parse(_ratingController.text),
                  };
                  _toAdd(row);
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _editDialog(Map<String, dynamic> json) {
    int id = json["id"];
    _titleController.text = json['title'];
    _authorController.text = json['author'];
    _ratingController.text = json['rating'].toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Book $id"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(hintText: "Title"),
              ),
              TextField(
                controller: _authorController,
                decoration: const InputDecoration(hintText: "Author"),
              ),
              TextField(
                controller: _ratingController,
                decoration: const InputDecoration(hintText: "Rating"),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
            ElevatedButton(
              onPressed: () {
                final row = {
                  DB.columnId: json['id'],
                  DB.columnTitle: _titleController.text,
                  DB.columnAuthor: _authorController.text,
                  DB.columnRating: double.parse(_ratingController.text),
                };
                _toUpdate(row);
                Navigator.of(context).pop();
              },
              child: const Text("Edit"),
            ),
          ],
        );
      },
    );
  }
}
