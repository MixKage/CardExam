import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'image_network_path.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widhtScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      body: widhtScreen > 650
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  flex: 4,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(pathImage),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: loginContainer(context),
                ),
              ],
            )
          : loginContainer(context),
    );
  }

  Widget loginContainer(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 650,
        minWidth: 0,
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 40,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[50],
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
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10)),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "password",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Забыли пароль?',
                      style: TextStyle(decoration: TextDecoration.underline),
                    )),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('LogIn'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
