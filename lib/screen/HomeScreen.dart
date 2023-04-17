import 'package:flutter/material.dart';
import 'package:login_using_shared_preference/screen/ListScreen.dart';
import 'package:login_using_shared_preference/screen/LoginScreen.dart';
import 'package:login_using_shared_preference/utils/customButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  // final drawerItems = [new DrawerItem("List", Icons.car_rental)];

  @override
  _HomeScreen createState() => _HomeScreen();
}

class DrawerItem {
  String title;
  IconData iconData;

  DrawerItem(this.title, this.iconData);
}

class _HomeScreen extends State<HomeScreen> {
  int selectedIndex = 0;

  getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return LoginScreen();
      default:
        return Text("Error in opening");
    }
  }

  onSelectItem(int index) {
    setState(() {
      selectedIndex = index;
      Navigator.of(context).pop();
    });
  }

  String liData = "";
  List<String> cUser = [];
  List<String> cUserData = [];
  String name = "";
  String email = "";

  getCUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cUser = prefs.getStringList("cUser")!;
    cUserData = prefs.getStringList(cUser[0])!;
    setState(() {
      name = cUserData[0];
      email = cUserData[2];
    });
  }

  @override
  void initState() {
    super.initState();
    getCUser();
  }

  @override
  Widget build(BuildContext context) {
    /*List<Widget> drawerOPtions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOPtions.add(ListTile(
        leading: Icon(d.iconData),
        title: Text(d.title),
        selected: i == selectedIndex,
        onTap: onSelectItem(i),
      ));
    }*/

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                name,
                style: const TextStyle(fontSize: 16),
              ),
              accountEmail: Text(
                email,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            /*Column(
              children: drawerOPtions,
            )*/
          ],
        ),
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
          Navigator.pop(context);
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
