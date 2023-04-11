import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class customButton {
  Widget customBtn(String label, onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.redAccent, width: 2.0),
        ),
        child: Center(
          child: MaterialButton(
            minWidth: double.infinity,
            onPressed: onPressed,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
