import 'package:cardexam/utilities/check_connection.dart';
import 'package:cardexam/utilities/login_function.dart';
import 'package:cardexam/widgets/login_page_widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final _formKey = GlobalKey<FormState>();

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _emailController;
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  late ValueNotifier<bool> _isPasswordVisibleNotifier;

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _isPasswordVisibleNotifier = ValueNotifier(true);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    _isPasswordVisibleNotifier.dispose();
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Theme.of(context).colorScheme.onPrimary),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          actions: [QuestionSignUp(context: context)],
          title: Text(
            'SignUn',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(
                right: 10.0,
                left: 10.0,
                top: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 14.0,
                    ),
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
                      horizontal: 20.0,
                      vertical: 14.0,
                    ),
                    child: TextFormField(
                      controller: _loginController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Пустое поле';
                        } else if (value.length < 4) {
                          return 'Никнейм должен состоять минимум '
                              'из 4 символов';
                        } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                          return 'Никнейм должен состоять из '
                              'английских букв и цифр';
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
                      horizontal: 20.0,
                      vertical: 14.0,
                    ),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _isPasswordVisibleNotifier,
                      builder: (context, isPasswordVisible, child) =>
                          TextFormField(
                        controller: _passwordController,
                        textInputAction: TextInputAction.next,
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
                          ),
                        ),
                      ),
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
                          } else if (value != _passwordController.text) {
                            return 'Пароли не совпадают';
                          } else if (value.length < 8) {
                            return 'Пароль должен содержать '
                                'минимум 8 символов';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Повторите пароль',
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
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 14.0,
                    ),
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        //Add isDense true and zero Padding.
                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        //Add more decoration as you want here
                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Выберите учебное заведение',
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                      ),
                      iconSize: 30,
                      buttonHeight: 60,
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      buttonPadding: const EdgeInsets.only(right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: educationItems
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Обязательное поле';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                      onSaved: (value) {
                        selectedEducation = value.toString();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 14.0,
                    ),
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        //Add isDense true and zero Padding.
                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        //Add more decoration as you want here
                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Выберите свой курс',
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                      ),
                      iconSize: 30,
                      buttonHeight: 60,
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      buttonPadding: const EdgeInsets.only(right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: courseItems
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Обязательное поле';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                      onSaved: (value) {
                        selectedCourse = value.toString();
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
                            mySnackBar(
                              iconSnack: const Icon(
                                Icons.wifi_off_outlined,
                                color: Colors.white60,
                              ),
                              text: 'Отсутсвует интернет подключение, '
                                  'войдите в режим гостя',
                            ),
                          );
                        } else if (_formKey.currentState!.validate() &&
                            selectedEducation != null &&
                            selectedCourse != null) {
                          debugPrint('Аккаунт создан');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            mySnackBar(
                              iconSnack: const Icon(
                                Icons.error_outline,
                                color: Colors.white60,
                              ),
                              text: 'Вы заполнили не все поля',
                            ),
                          );
                        }
                      },
                      buttonText: 'Создать Аккаунт',
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
