import 'package:cardexam/dio/server_service.dart';
import 'package:cardexam/navigation/navigation_service.dart';
import 'package:cardexam/theme/theme_manager.dart';
import 'package:cardexam/utilities/constants.dart';
import 'package:cardexam/widgets/widgets.dart';
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
                        final isLive = await isLiveServer();
                        final minimalNeedVersion = await getMinimalVersionApp();
                        if (isLive && minimalNeedVersion <= versionApp) {
                          await NavigationService.instance
                              .pushNamed(NavigationPaths.login);
                        } else {
                          if (!isLive) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              checkServerConnection(),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              mySnackBar(
                                iconSnack: const Icon(
                                  Icons.warning,
                                  color: Colors.white60,
                                ),
                                text: 'Версия приложения устарела, '
                                    'пожалуйста, обновите приложение',
                              ),
                            );
                          }
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
                        // if (!await hasNetwork()) {
                        final isLive = await isLiveServer();
                        final minimalNeedVersion = await getMinimalVersionApp();
                        if (isLive && minimalNeedVersion <= versionApp) {
                          await NavigationService.instance
                              .pushNamed(NavigationPaths.signUp);
                        } else {
                          if (!isLive) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              checkServerConnection(),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              mySnackBar(
                                iconSnack: const Icon(
                                  Icons.warning,
                                  color: Colors.white60,
                                ),
                                text: 'Версия приложения устарела, '
                                    'пожалуйста, обновите приложение',
                              ),
                            );
                          }
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
