import 'package:flutter/material.dart';

class myButton extends StatefulWidget {
  String text;
  double buttonHeight;
  Color buttonColor;

  myButton({super.key,
    required this.text,
  required this.buttonHeight,
  required this.buttonColor,
  });

  @override
  State<myButton> createState() => _myButtonState();
}

class _myButtonState extends State<myButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * widget.buttonHeight,
      color: widget.buttonColor,
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        onPressed: () {},
        child: Text(
          widget.text,
          style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
