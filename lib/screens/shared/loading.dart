import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class FloatingLoadingText extends StatefulWidget {
  const FloatingLoadingText({Key? key}) : super(key: key);

  @override
  _FloatingLoadingTextState createState() => _FloatingLoadingTextState();
}

class _FloatingLoadingTextState extends State<FloatingLoadingText> {
  @override
  Widget build(BuildContext context) {
    return TextLiquidFill(
      waveDuration: Duration(seconds: 3),
      boxBackgroundColor: Colors.blue,
      text: 'Loading',
      waveColor: Colors.orangeAccent,
      textStyle: const TextStyle(
        fontSize: 50.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
