import 'dart:math';

import 'package:flutter/material.dart';

class SudokuPole extends StatefulWidget {
  var _onPress = (int _v) => 0;
  int _value = 0;

  int W = 0;

  SudokuPole(int Function(int _v) onPress, {Key? key}) : super(key: key) {
    _onPress = onPress;

    var rng = Random();
    _value = 1 + rng.nextInt(10);
    W = _value;
  }

  @override
  State<StatefulWidget> createState() => SudokuPoleDynamic();
}

class SudokuPoleDynamic extends State<SudokuPole> {
  void sudokuButtonPressed() {
    setState(() {
      widget._value = widget._onPress(widget._value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: sudokuButtonPressed,
        child: Stack(alignment: Alignment.center, children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                )),
          ),
          Text('${widget._value}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  fontFamily: "ComicSans")),
        ]));
  }
}
