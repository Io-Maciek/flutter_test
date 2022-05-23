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
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int sudokuSize = 4;

  _MyHomePageState() {
    _plansza = _setKomorkiSudoku();
  }

  GridView _plansza = GridView.count(crossAxisCount: 1);
  final List<Widget> _komorki = <Widget>[];

  GridView _setKomorkiSudoku() {
    for (int i = 0; i < sudokuSize * sudokuSize; i++) {
      _komorki.add(SudokuPole((int i) {
        int ret = i;
        if (i < 9) {
          ret = ret + 1;
        } else {
          ret = 1;
        }
        return ret;
      }));
    }

    var grid = GridView.count(
      padding: EdgeInsets.all(20.0) ,
      childAspectRatio: sudokuSize/sudokuSize,
      mainAxisSpacing: 0.0,
      crossAxisSpacing: 0.0,
      crossAxisCount: sudokuSize,
      children: _komorki,
    );

    return grid;
  }

  void _incrementCounter() {
    print("Kliknięto COŚ na pewno");
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: [
        TextButton(
            style: style,
            onPressed: _incrementCounter,
            child: const Text('Action 1')),
      ]),
      body: Center(
              child: _plansza),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: "Dodaj",
        child: const Icon(Icons.dangerous),

      ));
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
