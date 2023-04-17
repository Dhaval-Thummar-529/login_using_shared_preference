import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_using_shared_preference/screen/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

import 'LoginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login System",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}



class _SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterFuture: checkUserExist(context),
      image: Image.asset('assets/images/login_icon.png'),
      loadingText: const Text("Loading"),
      photoSize: 100.0,
      loaderColor: Colors.blue.withOpacity(0.5),
    );
  }

  Future<void> checkUserExist(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cUser = [];
    cUser = prefs.getStringList("cUser");
    if (cUser == null || cUser[1] == "0") {
      Timer(
          const Duration(seconds: 5),
          () => {
                Navigator.pop(context),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()))
              });
    } else {
      Timer(
          const Duration(seconds: 5),
          () => {
                Navigator.pop(context),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  HomeScreen()))
              });
    }
  }
}
