import 'package:cardexam/navigation/navigation_service.dart';
import 'package:cardexam/widgets/login_page_widgets.dart';
import 'package:flutter/material.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Card\nExam',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.question_mark, size: 120),
                  const SizedBox(height: 10.0),
                  Text(
                    'Страница\nне найдена\n;(',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: BuildLoginBtn(
                  onPressed: () async {
                    final bool isSucces =
                        await Navigator.of(context).maybePop();
                    if (!isSucces) {
                      NavigationService.instance
                          .pushNamed(NavigationPaths.start);
                    }
                  },
                  buttonText: 'Home Page',
                ),
              ),
            ],
          ),
        ),
      );
}
