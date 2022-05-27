import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
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

  Orientation presentOrientation = Orientation.landscape;

  int R = 0;
  int C = 0;

  MainGridState() {
    for (int i = 0; i < sudokuSize; i++) {
      var tempRow = <SudokuPole>[];
      for (int j = 0; j < sudokuSize; j++) {
        if ((i == 3 && j == 0) || (i == 1 && j == 0)) {
          tempRow.add(SudokuPole.add());
        } else {
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
    if (presentOrientation != next) {
      print("OBRÓT");
      int t = R;
      R = C;
      C = t;

      for (int i = 0; i < sudokuSize; i++) {
        for (int j = i; j < sudokuSize; j++) {
          var pre = _komorki[i][j].value;
          _komorki[i][j].value = _komorki[j][i].value;
          _komorki[j][i].value = pre;
        }
      }
      presentOrientation = next;
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
              children: _komorki.expand((element) => element).toList()));

      var text = Text(
        '${temp}: $idRuchu',
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

    return RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (event) {
          if (event.runtimeType == RawKeyDownEvent) {
            if (event.data.logicalKey == LogicalKeyboardKey.arrowLeft ||
                event.data.logicalKey == LogicalKeyboardKey.keyA) {
              move(Movement.prawo);
            } else if (event.data.logicalKey == LogicalKeyboardKey.arrowRight ||
                event.data.logicalKey == LogicalKeyboardKey.keyD) {
              move(Movement.lewo);
            } else if (event.data.logicalKey == LogicalKeyboardKey.arrowUp ||
                event.data.logicalKey == LogicalKeyboardKey.keyW) {
              move(Movement.gora);
            } else if (event.data.logicalKey == LogicalKeyboardKey.arrowDown ||
                event.data.logicalKey == LogicalKeyboardKey.keyS) {
              move(Movement.dol);
            }
          }
        },
        child: GestureDetector(
          onDoubleTap: zapisz,
          onHorizontalDragEnd: (d) {
            if (d.velocity.pixelsPerSecond.dx < -250) {
              move(Movement.prawo);
            } else if (d.velocity.pixelsPerSecond.dx > 250) {
              move(Movement.lewo);
            }
          },
          onVerticalDragEnd: (d) {
            if (d.velocity.pixelsPerSecond.dy > -500) {
              move(Movement.dol);
            } else if (d.velocity.pixelsPerSecond.dy < 500) {
              move(Movement.gora);
            }
          },
          child: grid,
        ));
  }

  int idRuchu = 0;

  void after_move() {
    idRuchu++;

    bool isAdded = false;
    while (!isAdded) {
      var rnd = Random();
      var rnd2 = rnd.nextInt(sudokuSize);
      var rnd3 = rnd.nextInt(sudokuSize);
      if (_komorki[rnd2][rnd3].level == 0) {
        _komorki[rnd2][rnd3] = SudokuPole.add();
        isAdded = true;
      }
    }
  }

  void move(Movement movement) {
    setState(() {
      switch (movement) {
        case Movement.gora:
          if (presentOrientation == Orientation.landscape) {
            _moveRight();
          } else {
            _moveUp();
          }

          break;
        case Movement.dol:
          if (presentOrientation == Orientation.landscape) {
            _moveLeft();
          } else {
            _moveDown();
          }

          break;
        case Movement.lewo:
          if (presentOrientation == Orientation.landscape) {
            _moveDown();
          } else {
            // gdy pionowo to w lewo
            _moveLeft();
          }

          break;
        case Movement.prawo:
          if (presentOrientation == Orientation.landscape) {
            _moveUp();
          } else {
            // gdy pionowo to w prawo
            _moveRight();
          }

          break;
      }
    });
  }

  void _moveUp() {
    bool wykonalSieRuch = false;

    // dodac wykrywanie kolizji

    for (int i = 0; i < sudokuSize; i++) {
      for (int j = 0; j < sudokuSize; j++) {
        if (_komorki[i][j].level > 0) {
          for (int d = 0; d < i; d++) { // tu nie moze isc od poczatku tylko od nastepnego i sprawdzac czy jest wolne i
                                        // probowac isc dalej, jak nie to wrocic
            if (_komorki[d][j].level == 0) {
              _komorki[d][j] =
                  SudokuPole.set(_komorki[i][j].level); //new position
              _komorki[i][j] = SudokuPole(); //previous that was moved
              wykonalSieRuch = true;
              break;
            } else if (_komorki[d][j].level == _komorki[i][j].level) {
              print('$i:$j dodawnie');
              _komorki[d][j] =
                  SudokuPole.set(_komorki[d][j].level + 1); //added position
              _komorki[i][j] = SudokuPole(); //previous that was moved
              wykonalSieRuch = true;

              break;
            }

          }
        }
      }
    }

    if (wykonalSieRuch) {
      after_move();
    }
  }

  void _moveDown() {
    bool wykonalSieRuch = false;

    for (int i = sudokuSize - 1; i >= 0; i--) {

      for (int j = 0; j < sudokuSize; j++) {
        if (_komorki[i][j].level > 0) {

          for (int d = sudokuSize-1; d >i; d--) {

            if (_komorki[d][j].level == 0) {
              print("hej!");

              _komorki[d][j] =
                  SudokuPole.set(_komorki[i][j].level); //new position
              _komorki[i][j] = SudokuPole(); //previous that was moved
              wykonalSieRuch = true;
              break;
            }else if (_komorki[d][j].level == _komorki[i][j].level) {
              print("hej!");

              print('$i:$j dodawnie');
              _komorki[d][j] =
                  SudokuPole.set(_komorki[d][j].level + 1); //added position
              _komorki[i][j] = SudokuPole(); //previous that was moved
              wykonalSieRuch = true;

              break;
            }

          }
        }
      }
    }

    if (wykonalSieRuch) {
      after_move();
    }
  }

  void _moveLeft() {
/*    if (C < sudokuSize - 1) {
      _komorki[R][C] = SudokuPole.set('');
      C += 1;
      _komorki[R][C] = SudokuPole.set('T');
      after_move();
    }*/
  }

  void _moveRight() {
/*    if (C > 0) {
      _komorki[R][C] = SudokuPole.set('');
      C -= 1;
      _komorki[R][C] = SudokuPole.set('T');
      after_move();
    }*/
  }
}
