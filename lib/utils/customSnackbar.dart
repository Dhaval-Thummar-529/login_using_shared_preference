import 'package:flutter/material.dart';

class customSnackbar {
  void showSnackbar({label, context}) {
    final snackbar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(label),
      duration: const Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
