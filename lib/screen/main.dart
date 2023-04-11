import 'dart:async';

import 'package:flutter/material.dart';

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
    Timer(
        const Duration(seconds: 1),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SplashScreen"),
      ),
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
}
