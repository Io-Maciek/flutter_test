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
        scaffoldBackgroundColor: Colors.orange[50],
        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(
        title: '2048',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyHomePageState>()?.restartApp();
  }

  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: key,
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
        TextButton(
            style: TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary),
            onPressed: restartApp,
            child: const Text('Restart')),
      ]
      ),
      body: const MainGrid(),
      /* floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: "Dodaj",
          child: const Icon(Icons.dangerous),
        )*/
    ));
  }
}
