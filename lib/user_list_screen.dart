import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'db_helper.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  UserListScreenState createState() => UserListScreenState();
}

class UserListScreenState extends State<UserListScreen> {
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
    await dbHelper.saveUser(User(
      null,
      userData['name'] ?? '',
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
                    storeDataInSQLite(userList[index]);
                  },
                ),
              );
            },
          ),

          ElevatedButton(
            onPressed: () {
              fetchUsers();
            },
            child: const Text('Get More Users'),
          ),
          ElevatedButton(
            onPressed: () {
              storeDataInSQLite(userList as Map<String, dynamic>);
            },
            child: const Text('Store Data in SQLite'),
          ),
        ],
      ),
    );
  }
}
