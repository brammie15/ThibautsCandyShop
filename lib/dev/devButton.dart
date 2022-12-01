import 'package:flutter/material.dart';

class devButton extends StatelessWidget {
  const devButton({
    Key? key,
    required this.onClick,
    required this.buttonText,
    this.buttonColor = Colors.blue,
    this.textColorBlack = false,
  }) : super(key: key);

  final VoidCallback onClick;
  final String buttonText;
  final Color buttonColor;
  final bool textColorBlack;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
        ),
        child: Text(buttonText, style: TextStyle(color: textColorBlack ? Colors.black : Colors.white),),
      ),
    );
  }
}
