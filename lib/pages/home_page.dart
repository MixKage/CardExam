import 'package:cardexam/navigation/navigation_service.dart';
import 'package:cardexam/security/security.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<String?> _getJwt() async =>
      SecurityStorage.instance.getSecret(SecretInfo.jwt);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Theme.of(context).colorScheme.onPrimary),
          title: Text(
            'HomePage',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const Text('HomePage'),
              FutureBuilder<String?>(
                future: _getJwt(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text(
                      'Jwt: Error',
                      textAlign: TextAlign.center,
                    );
                  } else if (snapshot.hasData) {
                    return Text('Jwt ${snapshot.data}');
                  } else {
                    return const Text('Loading...');
                  }
                },
              ),
              ElevatedButton(
                onPressed: () {
                  SecurityStorage.instance.deleteAll();
                  NavigationService.instance
                      .pushNamedAndRemoveUntil(NavigationPaths.unknown);
                },
                child: const Text('SignOut'),
              ),
            ],
          ),
        ),
      );
}
