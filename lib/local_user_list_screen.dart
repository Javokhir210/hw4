import 'package:flutter/material.dart';
import 'db_helper.dart';

class LocalUserListScreen extends StatefulWidget {
  const LocalUserListScreen({Key? key}) : super(key: key);

  @override
  _LocalUserListScreenState createState() => _LocalUserListScreenState();
}

class _LocalUserListScreenState extends State<LocalUserListScreen> {
  List<Map<String, dynamic>> localUserList = [];

  @override
  void initState() {
    super.initState();
    _fetchLocalUserList();
  }

  Future<void> _fetchLocalUserList() async {
    DBHelper dbHelper = DBHelper();

    // Query all users from the database
    List<Map<String, dynamic>> users = (await dbHelper.getUsers()).cast<Map<String, dynamic>>();

    setState(() {
      localUserList = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local User List'),
      ),
      body: Column(
        children: [
          // Display local user information as a list
          // TODO: Implement your local user list UI here
          // For example:
          ListView.builder(
            shrinkWrap: true,
            itemCount: localUserList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(localUserList[index]['name'] ?? ''),
                // Add more fields as needed
              );
            },
          ),
        ],
      ),
    );
  }
}
