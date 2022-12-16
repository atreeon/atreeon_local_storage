import 'package:atreeon_local_storage/HasData.dart';
import 'package:atreeon_local_storage/atreeonLocalStorage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool initialised = false;
  late int _counter;
  final Future<SharedPreferences> prefsFuture = SharedPreferences.getInstance();

  void _incrementCounter() {
    setState(() {
      _counter++;
      setLocalStorageValue('counter', HasData_yes(_counter), prefsFuture);
    });
  }

  void initState() {
    asyncDataLoad();
    super.initState();
  }

  asyncDataLoad() async {
    var prefs = await prefsFuture;
    var value = (await getInt('counter', prefs)).valueOrDefault(0);
    _counter = value;
    initialised = true;
    setState(() => null);
  }

  Widget build(BuildContext context) {
    if (initialised)
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
    else
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: const Text(
            'Loading Data',
          ),
        ),
      );
  }
}
