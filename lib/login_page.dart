import 'package:flutter/material.dart';
import 'package:cardexam/main_page.dart';

class LoginPage2 extends StatefulWidget {
  const LoginPage2({Key? key}) : super(key: key);

  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  final int _minWidht = 600;
  @override
  Widget build(context) => SafeArea(
        child: Scaffold(body: LayoutBuilder(builder: (context, constraints) {
          return Container(
              color: Colors.lightGreen[200],
              padding: constraints.maxWidth < _minWidht
                  ? EdgeInsets.zero
                  : const EdgeInsets.all(100.0),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 25.0),
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            "Welcome to the app, please log in",
                            style: TextStyle(
                                fontSize:
                                    constraints.maxWidth < _minWidht ? 40 : 60),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSecondary,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "username",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSecondary,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "password",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth:
                                constraints.maxWidth < _minWidht ? 300 : 150,
                            minWidth:
                                constraints.maxWidth < _minWidht ? 250 : 150,
                            maxHeight:
                                constraints.maxWidth < _minWidht ? 100 : 50,
                            minHeight:
                                constraints.maxWidth < _minWidht ? 50 : 50,
                          ),
                          child: ElevatedButton(
                              child: const Text("Log in",
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              }),
                        )
                      ]),
                ),
              ));
        })),
      );
}
