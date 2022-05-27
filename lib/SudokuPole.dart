import 'package:flutter/material.dart';
import 'dart:math';

class SudokuPole extends StatefulWidget {
  String value = "";
  int level = 0;

  SudokuPoleDynamic child = SudokuPoleDynamic();

  SudokuPole({Key? key}) : super(key: key) {
    level=0;
    valueSetInit();

    child = SudokuPoleDynamic();
  }

  SudokuPole.add({Key? key}) : super(key: key) {
    level++;
    valueSetInit();

    child = SudokuPoleDynamic();
  }

  SudokuPole.set(int newLevel, {Key? key}) : super(key: key) {
    level=newLevel;
    valueSetInit();

    child = SudokuPoleDynamic();
  }


  void valueSetInit(){
    if(level == 0){
      value = "";
    }// else value equals to 2 to the power of level
    else{
      value = pow(2,level).toString();
    }
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
            color: Colors.orange[200]?.withOpacity(widget.level/11.0),
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
