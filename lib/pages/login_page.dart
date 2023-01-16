import 'package:cardexam/navigation/navigation_service.dart';
import 'package:cardexam/utilities/check_connection.dart';
import 'package:cardexam/utilities/login_function.dart';
import 'package:cardexam/widgets/login_page_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => DecoratedBox(
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
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
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
                const Text(
                  '- ИЛИ -',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Продолжить как гость',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'OpenSans',
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
                            text:
                                'Отсутсвует интернет подключение, войдите в режим гостя',
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

final _formKey = GlobalKey<FormState>();

class SecondLoginPage extends StatefulWidget {
  const SecondLoginPage({super.key});

  @override
  State<SecondLoginPage> createState() => _SecondLoginPageState();
}

class _SecondLoginPageState extends State<SecondLoginPage> {
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  late bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
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
                  ),
                ),
                SizedBox(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
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
                          Text(
                            'Card\nExam',
                            textAlign: TextAlign.center,
                            style: textLogoStyle(fontSize: 40.0),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              controller: _loginController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              autofocus: true,
                              decoration:
                                  const InputDecoration(labelText: 'Email'),
                              validator: (value) => validEmail(value!),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              controller: _passwordController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !_passwordVisible,
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
                                }
                                return null;
                              },

                              decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors
                                        .black54 /*Theme.of(context).primaryColorDark*/,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                            // TODO: хочется преврать это в отдельный виджет
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Hero(
                            tag: 'login_button',
                            child: BuildLoginBtn(
                              onPressed: () => {
                                if (_formKey.currentState!.validate())
                                  {print('SIGNIN')}
                              },
                              buttonText: 'Войти',
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
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
                              text:
                                  'Отсутсвует интернет подключение, войдите в режим гостя',
                            ),
                            /*const SnackBar(
                          content: ContentSnackBar(
                              iconSnack: Icon(
                                Icons.wifi_off_outlined,
                                color: Colors.black45,
                              ),
                              text:
                                  "Отсутсвует интернет подключение, войдите в режим гостя"),
                        ),*/
                          );
                        }
                      },
                    ),
                  ),
                ),
                SafeArea(
                  child: IconButton(
                    alignment: Alignment.topLeft,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                  ),
                ),
                //_buildSignupBtn(),
              ],
            ),
          ),
        ),
      );
}
