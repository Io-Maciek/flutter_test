import 'package:flutter/material.dart';
import 'package:my_first_flutter/MainGrid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048 - preview',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: '2048'),
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
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        /*actions: [
        TextButton(
            style: TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary),
            onPressed: _incrementCounter,
            child: const Text('Action 1')),
      ]*/
      ),
      body: const MainGrid(),
      /* floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: "Dodaj",
          child: const Icon(Icons.dangerous),
        )*/
    );
  }
}
