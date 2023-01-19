import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/*DecoratedBox(
decoration: const BoxDecoration(
gradient: LinearGradient(
begin: Alignment.topCenter,
end: Alignment.bottomCenter,
colors: [
Color(0xfff3f3f3),
Color(0xffe3e3e3),
],
stops: [0.1, 0.9],
),
),*/

void main() {
  runApp(const MyApp());
}

class TestValue {
  String text = 'XD';
}

Future<void> fetchAlbum() async {
  final jsonMap = {'text': 'olololo2'};
  final jsonMap2 = {
    'login': 'string',
    'password': 'string',
    'univercity': 'string',
    'direction': 'string',
    'grade': 0
  };
  debugPrint(jsonMap2.toString());

  final String jsonStr = jsonEncode(jsonMap);
  debugPrint(jsonStr);
  debugPrint(jsonMap.toString());
  debugPrint('++++++++');
  final response = await Dio()
      .post('http://192.168.1.143:7210/WeatherForecast')
      .then((result) {
    debugPrint(result.statusCode.toString());
    debugPrint(result.data);
  });
  debugPrint(response);

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
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, super.key});

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
  Widget build(BuildContext context) => Scaffold(
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
