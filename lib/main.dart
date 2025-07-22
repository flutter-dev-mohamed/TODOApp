import 'package:flutter/material.dart';

void main() {
  runApp(const thisApp());
}

class thisApp extends StatelessWidget {
  const thisApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            NumberView(counter: _counter)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//

class NumberView extends StatefulWidget {
  NumberView({super.key, required this.counter});
  int counter;
  @override
  State<NumberView> createState() => _NumberView();
}

class _NumberView extends State<NumberView> {
  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Text(
        '${widget.counter}',
        // style: TextStyle(fontSize: 14),
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
