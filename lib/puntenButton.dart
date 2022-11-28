import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class puntenButton extends StatelessWidget {
  puntenButton({
    Key? key,
    required this.onClick,
    required this.buttonText,
    this.width = 100,
    this.height = 50,
    this.buttonColor = Colors.blue,
    bool active = true,
  }) : super(key: key);
  bool active = true;
  final double width;
  final Color buttonColor;
  final double height;
  final String buttonText;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: active ? onClick : null,
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
      ),
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white, fontSize: 15.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
