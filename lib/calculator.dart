import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyCalculator extends StatefulWidget {
  const MyCalculator({Key? key}) : super(key: key);

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String _expression = '';
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        _expression = '';
      } else if (buttonText == '.') {
        if (!_expression.contains('.')) {
          // check if decimal already exists
          _expression += buttonText;
        }
      } else if (buttonText == '=') {
        Parser p = Parser();
        Expression exp = p.parse(_expression);
        ContextModel cm = ContextModel();
        var eval;
        try {
          eval = exp.evaluate(EvaluationType.REAL, cm);
          if (eval == eval.toInt()) {
            _expression = eval.toInt().toString();
          } else {
            _expression = eval.toString();
          }
        } catch (e) {
          if (e is UnsupportedError) {
            // use this to check for error
            _expression = 'N/A';
          } else {
            _expression = 'Invalid';
          }
        }
      } else if (buttonText == '⌫') {
        // handle backspace symbol
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else {
        _expression += buttonText.replaceAll(
            'x', '*'); // the cross on calculator is different.
      }
      _textController.text = _expression;
    });
  }

  Widget buildButton(String buttonText, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: color ?? Colors.white,
            padding: const EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget buildRow(List<String> texts, {Color? color}) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: texts.map((text) {
          final colorButtons = ['+', '-', 'x', '/', '%'];
          if (text == '=') {
            return buildButton(text, color: Colors.green.shade200);
          } else if (colorButtons.contains(text)) {
            return buildButton(text, color: Colors.amber.shade200);
          } else {
            return buildButton(text,
                color:
                    (['⌫', 'AC'].contains(text)) ? Colors.red.shade100 : color);
          }
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.grey[100],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Flutter Calculator',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            SizedBox(
              width: 150,
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  'by clown',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Material(
              elevation: 8.0,
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff9bdedbff),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                height: 100.0,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    _textController.text,
                    style: const TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  const SizedBox(height: 50.0),
                  buildRow(['AC', '%', '⌫', '/']),
                  // const SizedBox(height: 16.0),
                  buildRow(['7', '8', '9', 'x']),
                  // const SizedBox(height: 16.0),
                  buildRow(['4', '5', '6', '-']),
                  // const SizedBox(height: 16.0),
                  buildRow(['1', '2', '3', '+']),
                  // const SizedBox(height: 16.0),
                  buildRow(['0', '.', '=']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
