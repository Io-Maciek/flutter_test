import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:my_first_flutter/Movement.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SudokuPole.dart';

class MainGrid extends StatefulWidget {
  const MainGrid({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainGridState();
}

class MainGridState extends State<MainGrid> {
  final sudokuSize = 4;
  final _komorki = <List<SudokuPole>>[];
  late SharedPreferences prefs;
  String temp = "";
  String _swipeDirection = "placeholder";
  Orientation pre = Orientation.landscape;

  int R = 2;
  int C =2;

  MainGridState() {
    for (int i = 0; i < sudokuSize; i++) {
      var tempRow = <SudokuPole>[];
      for (int j = 0; j < sudokuSize; j++) {

        if(i==R && j==C){
          tempRow.add(SudokuPole.set(1));
        }else {
          tempRow.add(SudokuPole());
        }
      }
      _komorki.add(tempRow);
    }
    getSharedPreferences();
  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      temp = prefs.getString("temp") == null
          ? "BRAK"
          : (prefs.getString("temp") as String);
    });
  }


  void _komorkiObrot(Orientation next) {
    if (pre != next) {
      print("OBRÓT");

      for (int i = 0; i < sudokuSize; i++) {
        for (int j = i; j < sudokuSize; j++) {
          var pre = _komorki[i][j].value;
          _komorki[i][j].value = _komorki[j][i].value;
          _komorki[j][i].value = pre;
        }
      }
      pre = next;
    }
  }


  @override
  Widget build(BuildContext context) {
    var grid = OrientationBuilder(builder: (context, orientation) {
      _komorkiObrot(orientation);
      var grid = Expanded(
          child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              padding: const EdgeInsets.all(20.0),
              childAspectRatio: sudokuSize / sudokuSize,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              crossAxisCount: sudokuSize,
              children: _komorki.expand((element) => element).toList()
          ));

      var text = Text(
        '${temp}: $_swipeDirection',
        textAlign: TextAlign.center,
      ); //

      if (orientation == Orientation.portrait) {
        return Column(children: [
          grid,
          text,
        ]);
      } else {
        return Row(children: [
          grid,
          text,
        ]);
      }
    });

    void zapisz() {
      setState(() {
        var rnd = Random();
        temp = '${rnd.nextInt(101)}';
        prefs.setString("temp", temp);
      });
    }




    return GestureDetector(
      onDoubleTap: zapisz,

      onHorizontalDragEnd: (d) {
        if (d.velocity.pixelsPerSecond.dx < -250) {
          move(Movement.prawo);

          setState(() {
            _swipeDirection = "prawo";
          });
        } else if (d.velocity.pixelsPerSecond.dx > 250) {
          move(Movement.lewo);

          setState(() {
            _swipeDirection = "lewo";
          });
        }
      },
      onVerticalDragEnd: (d) {
        if (d.velocity.pixelsPerSecond.dy > -500) {
          move(Movement.dol);
          setState(() {
            _swipeDirection = "dół";
          });
        } else if (d.velocity.pixelsPerSecond.dy < 500) {
          move(Movement.gora);

          setState(() {
            _swipeDirection = "góra";
          });
        }
      },
      child: grid,
    );
  }

  void move(Movement movement){
    switch(movement){

      case Movement.gora:
        _moveUp();
        break;
      case Movement.dol:
        _moveDown();
        break;
      case Movement.lewo:
          _moveLeft();
        break;
      case Movement.prawo:
          _moveRight();
        break;
    }
  }

  void _moveUp(){
    if(R>0) {
      _komorki[R][C] = SudokuPole.set(0);
      R -= 1;
      _komorki[R][C] = SudokuPole.set(1);
    }
  }

  void _moveDown(){
    if(R<sudokuSize-1) {
      _komorki[R][C] = SudokuPole.set(0);
      R += 1;
      _komorki[R][C] = SudokuPole.set(1);
    }
  }

  void _moveLeft(){
    if(C<sudokuSize-1) {
      _komorki[R][C] = SudokuPole.set(0);
      C += 1;
      _komorki[R][C] = SudokuPole.set(1);
    }
  }

  void _moveRight(){
    if(C>0) {
      _komorki[R][C] = SudokuPole.set(0);
      C -= 1;
      _komorki[R][C] = SudokuPole.set(1);
    }
  }

}
