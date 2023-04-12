import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_using_shared_preference/screen/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginScreen.dart';

void main() {
  runApp(const SplashScreen());
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login System",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const _sScreen(),
    );
  }
}

class _sScreen extends StatefulWidget {
  const _sScreen({super.key});

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<_sScreen> {
  @override
  void initState() {
    super.initState();
    checkUserExist(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Wrap(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.redAccent, width: 2.0),
                ),
                child: const Center(
                  child: Text(
                    "Login System",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkUserExist(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cUser = [];
    cUser = prefs.getStringList("cUser");
    if (cUser == null || cUser[1] == "0") {
      Timer(
          const Duration(seconds: 3),
          () => {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()))
              });
    } else {
      Timer(
          const Duration(seconds: 3),
          () => {
                Navigator.pop(context),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()))
              });
    }
  }
}
