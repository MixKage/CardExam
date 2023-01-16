import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utilities/check_connection.dart';
import '../utilities/login_function.dart';
import '../widgets/login_page_widgets.dart';

final _formKey = GlobalKey<FormState>();

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _emailController;
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  late bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final List<String> educationItems = [
    'МИРЭА',
    'Финансовый',
    'ItHub',
  ];
  final List<String> courseItems = List<int>.generate(6, (i) => i + 1)
      .map((value) => value.toString())
      .toList();

  String? selectedEducation;
  String? selectedCourse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                    right: 10.0,
                    left: 10.0,
                    top: 60,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'SignUp',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff1e1f1e),
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          validator: (value) => validEmail(value!),
                          decoration: const InputDecoration(
                            labelText: 'Почта',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: TextFormField(
                          controller: _loginController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пустое поле';
                            } else if (value.length < 4) {
                              return 'Никнейм должен состоять минимум из 4 символов';
                            } else if (!RegExp(r"^[a-zA-Z0-9]+$")
                                .hasMatch(value)) {
                              return 'Никнейм должен состоять из английских букв и цифр';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Никнейм',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: TextFormField(
                          controller: _passwordController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !_passwordVisible,
                          // onFieldSubmitted: (value) => print('SIGNIN'),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(
                                "[a-zA-Z0-9 ! \" # \$ % & ' ( ) * + , \\ -. / : ; < = > ? @ ^ _ ` { | }]"))
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пустое поле';
                            } else if (value.length < 8) {
                              return 'Пароль должен содержать минимум 8 символов';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Пароль',
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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !_passwordVisible,
                          // onFieldSubmitted: (value) => print('SIGNIN'),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(
                                "[a-zA-Z0-9 ! \" # \$ % & ' ( ) * + , \\ -. / : ; < = > ? @ ^ _ ` { | }]"))
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пустое поле';
                            } else if (value != _passwordController.text) {
                              return 'Пароли не совпадают';
                            } else if (value.length < 8) {
                              return 'Пароль должен содержать минимум 8 символов';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Повторите пароль',
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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        child: CustomDropdownButton2(
                          buttonWidth: 250,
                          hint: 'Выберите учебное заведение',
                          dropdownItems: educationItems,
                          value: selectedEducation,
                          onChanged: (value) {
                            setState(() {
                              selectedEducation = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        child: CustomDropdownButton2(
                          buttonWidth: 250,
                          hint: 'Выберите курс',
                          dropdownItems: courseItems,
                          value: selectedCourse,
                          onChanged: (value) {
                            setState(() {
                              selectedCourse = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Hero(
                          tag: 'login_button',
                          child: BuildLoginBtn(
                              onPressed: () async {
                                if (!await hasNetwork()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    MySnackBar(
                                        iconSnack: const Icon(
                                          Icons.wifi_off_outlined,
                                          color: Colors.white60,
                                        ),
                                        text:
                                            "Отсутсвует интернет подключение, войдите в режим гостя"),
                                  );
                                } else if (_formKey.currentState!.validate() &&
                                    selectedEducation != null &&
                                    selectedCourse != null) {
                                  print('Аккаунт создан');
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(MySnackBar(
                                          iconSnack: const Icon(
                                            Icons.error_outline,
                                            color: Colors.white60,
                                          ),
                                          text: "Вы заполнили не все поля"));
                                }
                              },
                              buttonText: 'Создать Аккаунт')),
                      const SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_sharp)),
                    QuestionSignUp(context: context)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
