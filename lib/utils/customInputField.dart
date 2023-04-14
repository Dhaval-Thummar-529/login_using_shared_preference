import 'package:flutter/material.dart';

class customInputField {
  Widget customEdtField(
      String label,
      TextEditingController controller,
      FocusNode focusNode,
      TextInputType textInputType,
      TextInputAction textInputAction,
      bool obscureText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 10),
          TextField(
            obscureText: obscureText,
            controller: controller,
            focusNode: focusNode,
            maxLength: textInputType == TextInputType.phone ? 10 : null,
            keyboardType: textInputType,
            textInputAction: textInputAction,
            decoration: const InputDecoration(
              counterText: "",
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45)),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black45),
              ),
            ),
          )
        ],
      ),
    );
  }
}
