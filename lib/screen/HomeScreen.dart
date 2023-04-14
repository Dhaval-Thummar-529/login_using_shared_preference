import 'package:flutter/material.dart';
import 'package:login_using_shared_preference/screen/ListScreen.dart';
import 'package:login_using_shared_preference/screen/LoginScreen.dart';
import 'package:login_using_shared_preference/utils/customButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  String liData = "";
  List<String> cUser = [];
  List<String> cUserData = [];
  String name = "";

  getCUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cUser = prefs.getStringList("cUser")!;
    cUserData = prefs.getStringList(cUser[0])!;
    setState(() {
      name = cUserData[0];
    });
  }

  @override
  void initState() {
    super.initState();
    getCUser();
  }

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Welcome $name",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Center(
              child: liData.isNotEmpty
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
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  customButton().customBtn("List", () {
                    _navigateAndDisplaySelection(context);
                    /*Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListScreen()));*/
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
          Navigator.push(context,
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

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListScreen()),
    );

    if (!mounted) return;

    setState(() {
      if (result != null) {
        liData = result;
      } else {
        liData = "";
      }
    });
  }
}
