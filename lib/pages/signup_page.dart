import 'package:cardexam/dio/internet_service.dart';
import 'package:cardexam/utilities/login_function.dart';
import 'package:cardexam/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

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
  Widget? _questionsWidgets;
  //late List<QuestionHelper> myQuestionsHelper;

  Future<List<String>> _getUniverse() async =>
      InternetService.instance.getUniverses();

  Future<List<Widget>> _getListWidgetQuestions() async {
    final array = await InternetService.instance.getQuestionHelper();
    final List<Widget> widgetsQuest = <Widget>[];
    for (final quest in array) {
      if (quest.question.substring(0, 4) == 'uri:') {
        widgetsQuest.add(
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 15,
            ),
            child: ElevatedButton(
              onPressed: () {
                debugPrint('Открыта ссылка ${quest.question.substring(4)}');
              },
              child: Text(quest.answer),
            ),
          ),
        );
      } else {
        widgetsQuest.add(
          MyListTile(
            title: quest.question,
            subtitle: quest.answer,
          ),
        );
      }
    }
    return widgetsQuest;
  }

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

  // final List<String> educationItems = [
  //   'МИРЭА',
  //   'Финансовый',
  //   'ItHub',
  // ];
  final List<String> courseItems = List<int>.generate(6, (i) => i + 1)
      .map((value) => value.toString())
      .toList();

  String? selectedEducation;
  String? selectedCourse;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Theme.of(context).colorScheme.onPrimary),
          actions: [
            MyModalBottomSheet(
              context: context,
              listWidget: [
                _questionsWidgets ??
                    FutureBuilder<List<Widget>>(
                      future: _getListWidgetQuestions(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text(
                            'Error',
                            textAlign: TextAlign.center,
                          );
                        } else if (snapshot.hasData) {
                          _questionsWidgets = Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: List.generate(
                              snapshot.data!.length,
                              (index) => snapshot.data![index],
                            ),
                          );
                          return _questionsWidgets!;
                        } else {
                          return const Text('Loading...');
                        }
                      },
                    ),
              ],

              /*[
                const MyListTile(
                  title: 'Почему моего учебного заведения нет в списке?',
                  subtitle: 'Если вашего учебного заведения нет в списке, '
                      'заполните гугл форму',
                ),
                const MyListTile(
                  title: 'Что даёт регистрация?',
                  subtitle: 'Регистрация открывает доступ ко '
                      'всем возможностям CardExam',
                ),
                const MyListTile(
                  title: 'Для чего указывать почту?',
                  subtitle: 'Для получения уведомлений и восстановления пароля',
                ),
                const MyListTile(
                  title: 'Что такое CardExam?',
                  subtitle: 'Приложение позволяющее готовиться к любому '
                      'материалу в той или иной форме',
                ),
                const MyListTile(
                  title: 'Могу ли я добавить карточку с эказменом?',
                  subtitle:
                      'Конечно, но для этого необходимо зарегестрироваться. '
                      'Гостевой режим позволяет только '
                      'смотреть и запускать карточки',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 15,
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Добавить свой ВУЗ'),
                  ),
                ),
              ]*/
              icon: Icon(
                Icons.question_mark,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            )
          ],
          title: Text(
            'SignUp',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              //physics: const AlwaysScrollableScrollPhysics(),
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
                            splashRadius: 2,
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
                            splashRadius: 2,
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
                    child: FutureBuilder(
                      future: _getUniverse(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (snapshot.hasData) {
                          return DropdownButtonFormField2(
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
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
                            items: (snapshot.requireData as List?)
                                ?.map(
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
                            onChanged: (value) {
                              selectedEducation = value.toString();
                            },
                            onSaved: (value) {
                              selectedEducation = value.toString();
                            },
                          );
                        } else {
                          return Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white,
                            child: const Text('Universe Loading...'),
                          );
                        }
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
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
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
                      onChanged: (value) {
                        selectedCourse = value.toString();
                      },
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
                        if (!await InternetService.instance.isLiveServer()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            checkServerConnection(),
                          );
                        } else if (_formKey.currentState!.validate() &&
                            selectedEducation != null &&
                            selectedCourse != null) {
                          try {
                            await InternetService.instance.executeRequest(
                              InternetService.instance.createNewUser(
                                mail: _emailController.text,
                                username: _loginController.text,
                                password: _passwordController.text,
                                universe: selectedEducation!,
                                course: selectedCourse!,
                              ),
                            );
                            await InternetService.instance.executeRequest(
                              InternetService.instance.loginUser(),
                            );
                            await InternetService.instance.executeRequest(
                              InternetService.instance.checkAuth(),
                            );
                          } on DioError catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              mySnackBar(
                                iconSnack: const Icon(
                                  Icons.error_outline,
                                  color: Colors.white60,
                                ),
                                text: e.response.toString(),
                              ),
                            );
                          } on Exception catch (e) {
                            debugPrint(e.toString());
                          }
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
