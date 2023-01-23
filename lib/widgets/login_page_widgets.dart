import 'package:cardexam/theme/theme_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuildSignUpBtn extends StatelessWidget {
  final Function() onPressed;
  const BuildSignUpBtn({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: onPressed,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Нет аккаунта? ',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 18.0,
                      ),
                ),
                TextSpan(
                  text: 'Создай его',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ),
      );
}

class BuildLoginBtn extends StatelessWidget {
  final Function() onPressed;
  final String buttonText;
  const BuildLoginBtn({
    required this.onPressed,
    required this.buttonText,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
        ),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => {onPressed(), debugPrint('Pressed button')},
          child: Text(
            buttonText,
            style: const TextStyle(
              color: accentTextColorLight,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              //fontFamily: 'OpenSans',
            ),
          ),
        ),
      );
}

/*class PasswordTextFormField extends StatefulWidget {
  final TextEditingController passwordController;
  final bool passwordVisible;
  const PasswordTextFormField(
      {Key? key,
      required this.passwordController,
      required this.passwordVisible})
      : super(key: key);

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState(
      passwordController: passwordController, passwordVisible: passwordVisible);
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  final TextEditingController passwordController;
  late final bool passwordVisible;
  const _PasswordTextFormFieldState(
      {Key? key,
      required this.passwordController,
      required this.passwordVisible});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      obscureText: !passwordVisible,
      // onFieldSubmitted: (value) => print('SIGNIN'),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(
            "[a-zA-Z0-9 ! \" # \$ % & ' ( ) * + , \\ -. / : ; < = > ? @ ^ _ ` { | }]"))
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Пустое поле';
        } else if (validEnglish(value)) {
          return 'Пароль должен быть на английском';
        }
        return null;
      },

      decoration: InputDecoration(
        labelText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
        ),
      ),
    );
  }
}*/

class MyListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const MyListTile({
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
      );
}

class QuestionSignUp extends StatelessWidget {
  final BuildContext context;
  const QuestionSignUp({required this.context, super.key});

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            builder: (context) => Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 20,
                    ),
                    child: Container(
                      height: 5,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.grey.withAlpha(70),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Scrollbar(
                    child: ListView(
                      children: [
                        // const MyListTile(
                        //     title:
                        //         'Почему моего учебного заведения нет в списке?',
                        //     subtitle:
                        //         'Если вашего учебного заведения нет в списке, заполните гугл форму'),
                        const ListTile(
                          title: Text(
                              'Почему моего учебного заведения нет в списке?'),
                          subtitle: Text(
                              'Если вашего учебного заведения нет в списке, '
                              'заполните гугл форму'),
                        ),
                        const ListTile(
                          title: Text('Что даёт регистрация?'),
                          subtitle: Text('Регистрация открывает доступ ко '
                              'всем возможностям CardExam'),
                        ),
                        const ListTile(
                          title: Text('Для чего указывать почту?'),
                          subtitle: Text(
                              'Для получения уведомлений и восстановления пароля'),
                        ),
                        const ListTile(
                          title: Text('Что такое CardExam?'),
                          subtitle:
                              Text('Приложение позволяющее готовиться к любому '
                                  'материалу в той или иной форме'),
                        ),
                        const ListTile(
                          title:
                              Text('Могу ли я добавить карточку с эказменом?'),
                          subtitle: Text(
                              'Конечно, но для этого необходимо зарегестрироваться. '
                              'Гостевой режим позволяет только '
                              'смотреть и запускать карточки'),
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
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        icon: Icon(
          Icons.question_mark,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );
}

SnackBar mySnackBar({required Icon iconSnack, required String text}) =>
    SnackBar(
      backgroundColor: backgroundColorDarkDown,
      content: Row(
        children: <Widget>[
          // add your preferred icon here
          iconSnack,
          const SizedBox(width: 15.0),
          // add your preferred text content here
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );

TextStyle textLogoStyle({required double fontSize}) => TextStyle(
      color: const Color(0xff1e1f1e),
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
