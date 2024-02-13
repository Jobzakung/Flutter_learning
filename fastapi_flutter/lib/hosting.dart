import 'dart:convert';

import 'package:fastapi_flutter/class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Hosting extends StatefulWidget {
  const Hosting({Key? key}) : super(key: key);

  @override
  State<Hosting> createState() => _HostingState();
}

class _HostingState extends State<Hosting> {
  dynamic data = "";

  TextEditingController _nameController =
      TextEditingController(); // Moved outside the method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hosting'),
      ),
      body: Column(
        children: [
          Text("$data"),
          ElevatedButton(
            onPressed: () async {
              await fetchData(); // Await fetchData to ensure the UI updates properly
            },
            child: const Text("Fetch Data"),
          ),
          data.isEmpty
              ? const Text("No data")
              : SingleChildScrollView(
                  child: SizedBox(
                    height: 300,
                    child: toList(),
                  ),
                ),
          if (data == null) // Show a message if data is null
            const Text('No data available'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => insertData(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<RestApi> fetchData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/users'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      data = jsonData;
      setState(() {});
      return RestApi.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('failed to load json');
    }
  }
  // Future<void> fetchData() async {
  //   try {
  //     var url = Uri.parse('http://10.0.2.2:8000/users');
  //     final response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         data = jsonDecode(response.body);
  //       });
  //     } else {
  //       throw Exception('Failed to connect');
  //     }
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Failed to fetch data')),
  //     );
  //   }
  // }

  void insertData(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Register New User"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextField(
                  controller: _nameController,
                ),
                const Text("Enter the name of the user"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                addData(_nameController.text);
                Navigator.of(context).pop();
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  void UpdateData(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Update User"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextField(
                  controller: _nameController,
                ),
                const Text("Enter the new name of the user"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                add_edit(_nameController.text, data['id']);
                Navigator.of(context).pop();
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  Widget toList() {
    if (data == null || data.isEmpty) {
      return const Text('No data available');
    } else {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: const Icon(
                Icons.account_circle,
                color: Colors.red,
              ),
              title: Text("${data[index]?['name'] ?? 'Unknown'}"),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        UpdateData(context);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        delete(data[index]['id']);
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  Future<void> addData(String name) async {
    try {
      Map<String, dynamic> userData = {'name': name};
      var body = jsonEncode(userData);
      var response = await http.post(
        Uri.http('10.0.2.2:8000', '/users'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: body,
      );
      if (response.statusCode == 200) {
        await fetchData();
      } else {
        throw Exception('Failed to add data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add data')),
      );
    }
  }

  Future<void> add_edit(String userId, String newName) async {
    try {
      Map<String, dynamic> userData = {'name': newName};
      var body = jsonEncode(userData);
      var response = await http.put(
        Uri.http('10.0.2.2:8000', '/users/$userId'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: body,
      );
      if (response.statusCode == 200) {
        await fetchData();
      } else {
        throw Exception('Failed to update user');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update user')),
      );
    }
  }

  Future<void> delete(String userId) async {
    try {
      // Send a DELETE request to remove the user
      var url = Uri.parse('http://10.0.2.2:8000/users/$userId');
      var response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
      );
      if (response.statusCode == 200) {
        // Refresh data after successful deletion
        await fetchData();
      } else {
        throw Exception('Failed to delete user');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete user')),
      );
    }
  }
}
