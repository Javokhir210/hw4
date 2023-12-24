import 'package:flutter/material.dart';
import 'db_helper.dart';

class LocalUserListScreen extends StatefulWidget {
  const LocalUserListScreen({Key? key}) : super(key: key);

  @override
  LocalUserListScreenState createState() => LocalUserListScreenState();
}

class LocalUserListScreenState extends State<LocalUserListScreen> {
  List<Map<String, dynamic>> localUserList = [];

  @override
  void initState() {
    super.initState();
    _fetchLocalUserList();
  }

  Future<void> _fetchLocalUserList() async {
    DBHelper dbHelper = DBHelper();

    List<Map<String, dynamic>> users =
        (await dbHelper.getUsers()).cast<Map<String, dynamic>>();

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
          ListView.builder(
            shrinkWrap: true,
            itemCount: localUserList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(localUserList[index]['name'] ?? ''),
              );
            },
          ),
        ],
      ),
    );
  }
}
