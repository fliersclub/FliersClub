import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  String text;
  Color color;
  Function() onPressed;
  WelcomeButton(
      {required this.text, required this.onPressed, required this.color});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: StadiumBorder(),
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
