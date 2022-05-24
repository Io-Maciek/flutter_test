import 'package:flutter/material.dart';
import 'package:my_first_flutter/SudokuPole.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eluwa',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Elo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int sudokuSize = 4;
  final List<List<SudokuPole>> _komorki = <List<SudokuPole>>[];

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

  Orientation pre = Orientation.landscape;

  void _komorkiObrot(Orientation next) {
    if (pre != next) {
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

  String _swipeDirection ="placeholder";

  OrientationBuilder _buildPlansze() {
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

      var text = Text(_swipeDirection,
        textAlign: TextAlign.center,
      );

      if(orientation==Orientation.portrait){
        return Column(children: [
          grid,
          text,
        ]);
      }else{
        return Row(children: [
          grid,
          text,
        ]);
      }



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
            setState((){_swipeDirection="/\\";});
          } else if (d.velocity.pixelsPerSecond.dy > 250) {
            setState((){_swipeDirection="\\//";});

          }
        },
        onVerticalDragEnd: (d) {
          print("object");

          if (d.velocity.pixelsPerSecond.dx < -500) {
            print("W LEWOr");
          } else if (d.velocity.pixelsPerSecond.dx > 500) {
            setState((){_swipeDirection=">";});
          }
        },
        child: Scaffold(
            appBar: AppBar(title: Text(widget.title), actions: [
              TextButton(
                  style: style,
                  onPressed: _incrementCounter,
                  child: const Text('Action 1')),
            ]),
            body: _plansza,
            floatingActionButton: FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: "Dodaj",
              child: const Icon(Icons.dangerous),
            )));
  }
}
