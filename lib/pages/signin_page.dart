import 'package:cardexam/navigation/navigation_service.dart';
import 'package:cardexam/utilities/check_connection.dart';
import 'package:cardexam/utilities/login_function.dart';
import 'package:cardexam/widgets/login_page_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final _formKey = GlobalKey<FormState>();

class SecondLoginPage extends StatefulWidget {
  const SecondLoginPage({super.key});

  @override
  State<SecondLoginPage> createState() => _SecondLoginPageState();
}

class _SecondLoginPageState extends State<SecondLoginPage> {
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  late ValueNotifier<bool> _isPasswordVisibleNotifier;

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
    _isPasswordVisibleNotifier = ValueNotifier(true);
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _isPasswordVisibleNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Theme.of(context).colorScheme.onPrimary),
          title: Text(
            'SignIn',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  //physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                    right: 10.0,
                    left: 10.0,
                    top: 60,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            controller: _loginController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: true,
                            decoration:
                                const InputDecoration(labelText: 'Почта'),
                            validator: (value) => validEmail(value!),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 14.0,
                          ),
                          child: ValueListenableBuilder<bool>(
                            valueListenable: _isPasswordVisibleNotifier,
                            builder: (context, isPasswordVisible, child) =>
                                TextFormField(
                              controller: _passwordController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: isPasswordVisible,
                              // onFieldSubmitted: (value) => print('SIGNIN'),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(
                                    "[a-zA-Z0-9 ! \" # \$ % & ' ( ) * + , \\ -. / : ; < = > ? @ ^ _ ` { | }]",
                                  ),
                                )
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Пустое поле';
                                } else if (value.length < 8) {
                                  return 'Пароль должен содержать '
                                      'минимум 8 символов';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Пароль',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisibleNotifier.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    _isPasswordVisibleNotifier.value =
                                        !_isPasswordVisibleNotifier.value;
                                  },
                                  splashRadius: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Hero(
                          tag: 'login_button',
                          child: BuildLoginBtn(
                            onPressed: () => {
                              if (_formKey.currentState!.validate())
                                {debugPrint('SIGNIN')}
                            },
                            buttonText: 'Войти',
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            NavigationService.instance
                                .pushNamed(NavigationPaths.unknown);
                          },
                          child: const Text('Забыли пароль?'),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: BuildSignUpBtn(
                    onPressed: () async {
                      if (await hasNetwork()) {
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
              ),
            ],
          ),
        ),
      );
}
