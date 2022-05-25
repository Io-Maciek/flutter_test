
import 'package:flutter/material.dart';

class SudokuPole extends StatefulWidget {
  //var _onPress = (int _v) => 0;
  int value = 0;
  SudokuPoleDynamic child = SudokuPoleDynamic();

  SudokuPole({Key? key}) : super(key: key) {
    //_onPress = onPress;
    child = SudokuPoleDynamic();
  }

  SudokuPole.set(int setValue, {Key? key}) : super(key: key) {
    value = setValue;
    child = SudokuPoleDynamic();
  }

  @override
  State<StatefulWidget> createState() => SudokuPoleDynamic();//child;
}

class SudokuPoleDynamic extends State<SudokuPole> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        //onTap: sudokuButtonPressed,
        child: Stack(alignment: Alignment.center, children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            )),
      ),
      Text('${widget.value}',
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 21,
              fontWeight: FontWeight.bold,
              fontFamily: "ComicSans")),
    ]));
  }
}
