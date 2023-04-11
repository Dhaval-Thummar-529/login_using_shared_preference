import 'package:flutter/material.dart';
import 'package:login_using_shared_preference/screen/ListScreen.dart';
import 'package:login_using_shared_preference/utils/customButton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
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
            const Expanded(
              child: Center(
                child: Text(
                  "Demo Text",
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListScreen()));
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
