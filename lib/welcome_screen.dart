import 'package:flutter/material.dart';
import 'package:hw4/user_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _showTutorial = true;

  @override
  void initState() {
    super.initState();
    checkFirstLaunch();
  }

  Future<void> checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('firstLaunch') ?? true;

    if (isFirstLaunch) {
      // Show tutorial
      // TODO: Implement your tutorial logic here

      // Set the flag to false for subsequent launches
      prefs.setBool('firstLaunch', false);
    } else {
      // Redirect to the main screen or another screen
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
      body: _showTutorial
          ? const Text('Show your tutorial here')
          : const CircularProgressIndicator(),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: const WelcomeScreen(),
    ),
  );
}
