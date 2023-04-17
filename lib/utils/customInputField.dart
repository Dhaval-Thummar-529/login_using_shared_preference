import 'package:flutter/material.dart';

class customInputField {
  Widget customEdtField(
      String label,
      TextEditingController controller,
      FocusNode focusNode,
      TextInputType textInputType,
      TextInputAction textInputAction,
      bool obscureText,Icon prefixIcon,bool enabled) {
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
            enabled: enabled,
            controller: controller,
            focusNode: focusNode,
            maxLength: textInputType == TextInputType.phone ? 10 : null,
            keyboardType: textInputType,
            textInputAction: textInputAction,
            decoration:  InputDecoration(
              prefixIcon: prefixIcon,
              counterText: "",
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45)),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black45),
              ),
            ),
          )
        ],
      ),
    );
  }
}
