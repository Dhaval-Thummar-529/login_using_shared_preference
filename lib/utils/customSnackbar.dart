import 'package:flutter/material.dart';

class customSnackbar {
  void showSnackbar({label, context}) {
    final snackbar = SnackBar(
      content: Text(label),
      duration: const Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
