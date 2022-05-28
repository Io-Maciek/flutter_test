import 'package:flutter/material.dart';
import 'dart:math';

class SudokuPole extends StatefulWidget {
  String value = "";
  int level = 0;

  SudokuPoleDynamic child = SudokuPoleDynamic();

  SudokuPole({Key? key}) : super(key: key) {
    level = 0;
    valueSetInit();

    child = SudokuPoleDynamic();
  }

  SudokuPole.add({Key? key}) : super(key: key) {
    level++;
    valueSetInit();

    child = SudokuPoleDynamic();
  }

  SudokuPole.set(int newLevel, {Key? key}) : super(key: key) {
    level = newLevel;
    valueSetInit();

    child = SudokuPoleDynamic();
  }

  void valueSetInit() {
    if (level == 0) {
      value = "";
    } // else value equals to 2 to the power of level
    else {
      value = pow(2, level).toString();
    }
  }

  @override
  State<StatefulWidget> createState() => SudokuPoleDynamic();
}

class SudokuPoleDynamic extends State<SudokuPole> {
  @override
  Widget build(BuildContext context) {
    var bgColor = Colors.white.withOpacity(0.27);

    switch (widget.level) {
      case 0:
        bgColor = Colors.white.withOpacity(0.27);
        break;
      case 1:
        bgColor = Colors.orange.shade100;
        break;
      case 2:
        bgColor = Colors.orange.shade200;
        break;
      case 3:
        bgColor = Colors.orange.shade800;
        break;
      case 4:
        bgColor = Colors.redAccent;
        break;
      case 5:
        bgColor = Colors.pinkAccent;
        break;
      case 6:
        bgColor = Colors.deepPurpleAccent;
        break;
      case 7:
        bgColor = Colors.green;
        break;
      default:
        bgColor = Colors.white70;
        break;
    }

    return Container(
        padding: const EdgeInsets.all(5),
        child: Stack(alignment: Alignment.center, children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: bgColor,
            ),
          ),
          Text(widget.value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  fontFamily: "ComicSans")),
        ]));
  }
}
