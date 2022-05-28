import 'package:flutter/material.dart';
import 'dart:math';

class SudokuPole extends StatefulWidget {
  String value = "";
  int level = 0;
  bool doAnimate= false;

  SudokuPoleDynamic child = SudokuPoleDynamic();

  SudokuPole({Key? key}) : super(key: key) {
    level = 0;
    valueSetInit();
    doAnimate= false;
    child = SudokuPoleDynamic();
  }

  SudokuPole.add({Key? key}) : super(key: key) {
    level++;
    valueSetInit();
    doAnimate = true;

    child = SudokuPoleDynamic();
  }

  SudokuPole.set(int newLevel, {Key? key}) : super(key: key) {
    level = newLevel;
    valueSetInit();
    doAnimate= false;
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

class SudokuPoleDynamic extends State<SudokuPole> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 606),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



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

    Widget mainContainer =Container(
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

    /*if(widget.doAnimate){
      _controller.forward();
      mainContainer = ScaleTransition(scale: _animation,child: mainContainer);
    }*/

    return mainContainer;
  }
}
