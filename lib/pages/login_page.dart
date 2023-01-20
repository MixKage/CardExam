import 'package:cardexam/navigation/navigation_service.dart';
import 'package:cardexam/theme/theme_manager.dart';
import 'package:cardexam/utilities/check_connection.dart';
import 'package:cardexam/widgets/login_page_widgets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    ThemeManager.instance
                        .toggleTheme(!ThemeManager.instance.isDark());
                  },
                  icon: const Icon(Icons.dark_mode_outlined),
                  splashRadius: 16,
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'Card Exam',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const Spacer(),
                  Hero(
                    tag: 'login_button',
                    child: BuildLoginBtn(
                      onPressed: () async {
                        if (await hasNetwork()) {
                          await NavigationService.instance
                              .pushNamed(NavigationPaths.login);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            mySnackBar(
                              iconSnack: const Icon(
                                Icons.wifi_off_outlined,
                                color: Colors.white60,
                              ),
                              text: 'Отсутсвует интернет подключение,'
                                  ' войдите в режим гостя',
                            ),
                          );
                        }
                      },
                      buttonText: 'Войти',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '- ИЛИ -',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                    onPressed: () {
                      debugPrint('Продолжить как гость');
                    },
                    child: const Text(
                      'Продолжить как гость',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: BuildSignUpBtn(
                      onPressed: () async {
                        if (!await hasNetwork()) {
                          await NavigationService.instance
                              .pushNamed(NavigationPaths.signUp);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            mySnackBar(
                              iconSnack: const Icon(
                                Icons.wifi_off_outlined,
                                color: Colors.white60,
                              ),
                              text: 'Отсутсвует интернет подключение, '
                                  'войдите в режим гостя',
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
