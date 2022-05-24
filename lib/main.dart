import 'package:flutter/material.dart';
import 'package:my_first_flutter/MainGrid.dart';
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
        body: MainGrid(),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: "Dodaj",
          child: const Icon(Icons.dangerous),
        ));
  }
}
