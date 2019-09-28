import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({Key key, this.text, this.onPressed}) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: const Color(0xFF0091FB),
        textColor: Colors.white,
        child: Text(text),
        onPressed: onPressed,
        padding: EdgeInsets.symmetric(horizontal: 16),
      );
}
