import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'class.dart';

class Hosting extends StatefulWidget {
  const Hosting({Key? key});

  @override
  State<Hosting> createState() => _HostingState();
}

class _HostingState extends State<Hosting> {
  List<Users>? users = [];

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/users'));
    if (response.statusCode == 200) {
      setState(() {
        users = Restapi.fromJson(jsonDecode(response.body)).users;
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> insertUser(String name) async {
    final Map<String, dynamic> userData = {
      'id': 0, // Assuming the server generates the ID
      'name': name,
    };
    final String userJson = jsonEncode(userData);

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/users'),
      body: userJson,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      fetchUsers(); // Refresh user list
    } else {
      throw Exception(
          'Failed to insert user. Status code: ${response.statusCode}');
    }
  }

  Future<void> updateUser(Users user) async {
    final response = await http.put(
      Uri.parse('http://10.0.2.2:8000/users/${user.id}'),
      body: jsonEncode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      setState(() {
        users!.forEach((element) {
          if (element.id == user.id) {
            element.name = user.name;
          }
        });
      });
      // User updated successfully
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(int userId) async {
    final response =
        await http.delete(Uri.parse('http://10.0.2.2:8000/users/$userId'));
    if (response.statusCode == 200) {
      setState(() {
        users!.removeWhere((user) => user.id == userId);
      });
    } else {
      throw Exception('Failed to delete user');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        backgroundColor: Colors.blueGrey,
      ),
      body: users == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users!.length,
              itemBuilder: (context, index) {
                return UserCard(
                  user: users![index],
                  onUpdate: updateUser,
                  onDelete: deleteUser,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddUserDialog(
                onAddUser: insertUser,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
