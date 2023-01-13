import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class TestValue {
  String text = "XD";
}

Future<void> fetchAlbum() async {
  var jsonMap = {'text': 'olololo2'};
  var jsonMap2 = {
    "login": "string",
    "password": "string",
    "univercity": "string",
    "direction": "string",
    "grade": 0
  };
  print(jsonMap2);

  String jsonStr = jsonEncode(jsonMap);
  print(jsonStr);
  print(jsonMap);
  print("++++++++");
  var response = await Dio()
      .post('http://192.168.1.143:7210/WeatherForecast')
      .then((result) {
    print(result.statusCode);
    print(result.data);
  });
  print(response);

  //final response = await http.put(Uri.parse('http://192.168.1.143:5293/WeatherForecast'), body: new TestValue());
  // if (response != null) {
  //   debugPrint("AllWork");
  // }
  // if (response.statusCode == 200) {
  //   // If the server did return a 200 OK response,
  //   // then parse the JSON.
  //   return response.body.toString();
  // } else {
  //   // If the server did not return a 200 OK response,
  //   // then throw an exception.
  //   throw Exception('Failed to load album');
  // }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
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
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<void> _incrementCounter() async {
    await fetchAlbum();
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
