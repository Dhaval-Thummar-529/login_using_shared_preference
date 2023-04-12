import 'package:flutter/material.dart';
import 'package:login_using_shared_preference/screen/ListScreen.dart';
import 'package:login_using_shared_preference/screen/LoginScreen.dart';
import 'package:login_using_shared_preference/utils/customButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  var liData;

  HomeScreen({super.key, this.liData});

  @override
  _HomeScreen createState() => _HomeScreen(liData: liData);
}

class _HomeScreen extends State<HomeScreen> {
  var liData;

  _HomeScreen({this.liData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: liData != null
                    ? Text(
                        liData,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Text(
                        "",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  customButton().customBtn("List", () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => ListScreen()));
                  })
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Sign out",
        onPressed: () {
          signout();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
        child: const Icon(
          Icons.logout,
          color: Colors.white,
        ),
      ),
    );
  }

  void signout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("cUser", ["", "0"]);
  }
}
