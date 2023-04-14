import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  ListScreen({super.key});

  final List<String> _li = [
    "Volvo",
    "BMW",
    "Ford",
    "Mazda",
    "Mercedes",
    "Porsche"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lists"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black)),
              child: const Text(
                "List of Cars",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: _li.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: ListTile(
                      hoverColor: Colors.blue.withOpacity(0.5),
                      title: Center(
                        child: Text(
                          '${_li[index]}',
                          style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context, _li[index]);
                      },
                    ),
                  );
                  /*child: Text(
                      '${_li[index]}',
                      style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                  o*/
                }),
          ],
        ),
      ),
    );
  }
}
