import 'package:flutter/material.dart';

TextStyle whiteTextStyle() {
  return TextStyle(color: Colors.white);
}

TextStyle mediumWhiteTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 17);
}

InputDecoration textFieldDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.white54,
      ),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}
