import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.orange[800],
          size: 50.0,
        ),
      ),
    );
  }
}
