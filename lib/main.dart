import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_first_flutter/SudokuPole.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key) {}

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eluwa',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Elo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key) {}

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int sudokuSize = 4;
  List<List<SudokuPole>> _komorki = <List<SudokuPole>>[];

  _MyHomePageState() {
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
    _plansza = _buildPlansze();
  }

  var _plansza = OrientationBuilder(builder: (c, b) {
    return const Text("placeholder");
  });

  Orientation pre=Orientation.landscape;

  void _komorkiObrot(Orientation next) {
    if(pre!=next) {
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

  OrientationBuilder _buildPlansze() {
    var grid = OrientationBuilder(
        builder: (context, orientation) {
          _komorkiObrot(orientation);
      return GridView.count(
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
      );
    });

    return grid;
  }

  void _incrementCounter() {
    print("Kliknięto COŚ na pewno");
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);

    return GestureDetector(
        onHorizontalDragEnd: (d) {
          if (d.velocity.pixelsPerSecond.dy < -250) {
            print("W górę");
          } else if (d.velocity.pixelsPerSecond.dy > 250) {
            print("W dół");
          }
        },
        onVerticalDragEnd: (d) {
          if (d.velocity.pixelsPerSecond.dx < -500) {
            print("W lewo");
          } else if (d.velocity.pixelsPerSecond.dx > 500) {
            print("W prawo");
          }
        },
        child: Scaffold(
            appBar: AppBar(title: Text(widget.title), actions: [
              TextButton(
                  style: style,
                  onPressed: _incrementCounter,
                  child: const Text('Action 1')),
            ]),
            body: Center(child: _plansza),
            floatingActionButton: FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: "Dodaj",
              child: const Icon(Icons.dangerous),
            )));
  }
}

/*GestureDetector(
          onHorizontalDragEnd: (d) {
/*            if((d.primaryVelocity?.toInt()??0)>0){
              print("W lewo");
            }
            if((d.primaryVelocity?.toInt()??0)<0){
              print("W prawo");
            }
          },
          onVerticalDragEnd: (d) {
            if((d.primaryVelocity?.toInt()??0)>0){
              print("W górę");
            }


            if((d.primaryVelocity?.toInt()??0)<0){
              print("W doł");
            }*/
          },
          child: */
