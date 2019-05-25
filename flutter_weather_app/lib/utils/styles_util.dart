import 'package:flutter/material.dart';

TextStyle tempStyle() {
  return new TextStyle(
    color: Colors.white,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontSize: 34.3,
  );
}

TextStyle cityStyle() {
  return new TextStyle(
      color: Colors.white, fontSize: 22.9, fontStyle: FontStyle.italic);
}

TextStyle promptStyle() {
  return TextStyle(
      fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.red[200]);
}
