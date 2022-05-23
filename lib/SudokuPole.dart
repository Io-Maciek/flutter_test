import 'dart:math';

import 'package:flutter/material.dart';

class SudokuPole extends StatefulWidget{

  var _onPress = (int _v)=>0;

  SudokuPole(int Function(int _v) onPress, {Key? key}) : super(key: key){
    _onPress = onPress;
  }


  @override
  State<StatefulWidget> createState() => SudokuPoleDynamic(_onPress);

}

class SudokuPoleDynamic extends State<SudokuPole>{

  int _value=0;

  SudokuPoleDynamic(int Function(int _v) onPress){
    _onPress = onPress;

    var rng = Random();
    _value = 1+rng.nextInt(10);
  }


  void sudokuButtonPressed(){
    setState((){_value = _onPress(_value);});
  }


  var _onPress = (int _v)=>0;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: sudokuButtonPressed,
      child: Text(
          '$_value',
          style: const TextStyle(
              color:  Colors.black)
      ),
    );
  }

}