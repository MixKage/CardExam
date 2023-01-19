import 'package:cardexam/widgets/login_page_widgets.dart';
import 'package:flutter/material.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Card Exam',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.question_mark, size: 42),
                  Text(
                    'Page not found',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: BuildLoginBtn(onPressed: () {}, buttonText: 'Home Page'),
              ),
            ],
          ),
        ),
      );
}
