import 'package:flutter/material.dart';

class SudokuPole extends StatefulWidget {
  String value = "";
  SudokuPoleDynamic child = SudokuPoleDynamic();

  SudokuPole({Key? key}) : super(key: key) {
    child = SudokuPoleDynamic();
  }

  SudokuPole.set(String setValue, {Key? key}) : super(key: key) {
    value = setValue;
    child = SudokuPoleDynamic();
  }

  @override
  State<StatefulWidget> createState() => SudokuPoleDynamic();
}

class SudokuPoleDynamic extends State<SudokuPole> {
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            )),
      ),
      Text(widget.value,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 21,
              fontWeight: FontWeight.bold,
              fontFamily: "ComicSans")),
    ]);
  }
}
