import 'package:flutter/material.dart';

var textInputDecodartion = InputDecoration(
    fillColor: Colors.black,
    filled: true,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));

var elevatedButtonStyle = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(15.0),
)));
