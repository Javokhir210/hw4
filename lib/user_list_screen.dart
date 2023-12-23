import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'db_helper.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<Map<String, dynamic>> userList = [];
  DBHelper dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('https://api.example.com/users'));
    if (response.statusCode == 200) {
      final List<dynamic> results = jsonDecode(response.body);
      setState(() {
        userList = results.cast<Map<String, dynamic>>();
      });
    }
  }

  Future<void> storeDataInSQLite(Map<String, dynamic> userData) async {
    // Store the selected data in SQLite
    await dbHelper.saveUser(User(
      null,
      userData['name'] ?? '',
      // Add more fields as needed
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: Column(
        children: [
          // Display user information as a list
          // TODO: Implement your user list UI here
          // For example:
          ListView.builder(
            shrinkWrap: true,
            itemCount: userList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(userList[index]['name'] ?? ''),
                // Add more fields as needed
                trailing: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // Store selected data in SQLite
                    storeDataInSQLite(userList[index]);
                  },
                ),
              );
            },
          ),

          // Buttons to get more users and store data in SQLite
          ElevatedButton(
            onPressed: () {
              // Fetch more users from the API
              fetchUsers();
            },
            child: const Text('Get More Users'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Store selected data in SQLite
            },
            child: const Text('Store Data in SQLite'),
          ),
        ],
      ),
    );
  }
}
