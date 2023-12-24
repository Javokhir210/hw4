import 'package:flutter/material.dart';
import 'package:hw4/user_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpeningScreen extends StatefulWidget {
  const OpeningScreen({Key? key}) : super(key: key);

  @override
  OpeningScreenState createState() => OpeningScreenState();
}

class OpeningScreenState extends State<OpeningScreen> {
  bool ShowingSomething = true;

  @override
  void initState() {
    super.initState();
    checkFirstLaunch();
  }

  Future<void> checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('firstLaunch') ?? true;

    if (isFirstLaunch) {

      prefs.setBool('firstLaunch', false);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserListScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: ShowingSomething
          ? const Text('Here showing a text for something')
          : const CircularProgressIndicator(),
    );
  }
}
