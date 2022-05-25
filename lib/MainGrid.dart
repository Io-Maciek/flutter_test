import 'dart:math';

import 'package:flutter/cupertino.dart';
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

  MainGridState() {
    getSharedPreferences();

    for (int i = 0; i < sudokuSize; i++) {
      var tempRow = <SudokuPole>[];
      for (int j = 0; j < sudokuSize; j++) {
        tempRow.add(SudokuPole((int i) {
          int ret = i;
          if (i < 9) {
            ret = ret + 1;
          } else {
            ret = 1;
          }
          return ret;
        }));
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

  Orientation pre = Orientation.landscape;

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

  String _swipeDirection = "placeholder";

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
              children: _komorki.expand((element) => element).toList()));

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
          setState(() {
            _swipeDirection = "prawo";
          });
        } else if (d.velocity.pixelsPerSecond.dx > 250) {
          setState(() {
            _swipeDirection = "lewo";
          });
        }
      },
      onVerticalDragEnd: (d) {
        if (d.velocity.pixelsPerSecond.dy > -500) {
          setState(() {
            _swipeDirection = "dół";
          });
        } else if (d.velocity.pixelsPerSecond.dy < 500) {
          setState(() {
            _swipeDirection = "góra";
          });
        }
      },
      child: grid,
    );
  }
}
