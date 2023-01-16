import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class BuildSignUpBtn extends StatelessWidget {
  final Function() onPressed;
  const BuildSignUpBtn({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () => onPressed(),
        child: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Нет аккаунта? ',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Создай его',
                style: TextStyle(
                  color: Colors.black54,
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
}

class BuildLoginBtn extends StatelessWidget {
  final Function() onPressed;
  final String buttonText;
  const BuildLoginBtn(
      {Key? key, required this.onPressed, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25.0,
      ),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 3.0,
          backgroundColor: const Color(0xfff1f1f1),
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () => {onPressed(), debugPrint('Pressed button')},
        child: Text(
          buttonText,
          style: const TextStyle(
            color: accentTextColor,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
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

class QuestionSignUp extends StatelessWidget {
  final BuildContext context;
  const QuestionSignUp({Key? key, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return ListView(
              children: const [
                SizedBox(height: 15),
                ListTile(
                  title: Text('Почему моего учебного заведения нет в списке?'),
                  subtitle: Text(
                      'Если вашего учебного заведения нет в списке, заполните гугл форму'),
                ),
                ListTile(
                  title: Text('Что даёт регистрация?'),
                  subtitle: Text(
                      'Регистрация открывает доступ ко всем возможностям CardExam'),
                ),
                ListTile(
                  title: Text('Для чего указывать почту?'),
                  subtitle:
                      Text('Для получения уведомлений и восстановления пароля'),
                ),
                ListTile(
                  title: Text('Что такое CardExam?'),
                  subtitle: Text(
                      'Приложение позволяющее готовиться к любому материалу в той или иной форме'),
                ),
                ListTile(
                  title: Text('Могу ли я добавить карточку с эказменом?'),
                  subtitle: Text(
                      'Конечно, но для этого необходимо зарегестрироваться. Гостевой режим позволяет только смотреть и запускать карточки'),
                ),
              ],
            );
          },
        );
      },
      icon: const Icon(Icons.question_mark),
    );
  }
}

SnackBar mySnackBar({required Icon iconSnack, required String text}) {
  return SnackBar(
    content: Row(
      children: <Widget>[
        // add your preferred icon here
        iconSnack,
        const SizedBox(width: 15.0),
        // add your preferred text content here
        Flexible(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}

TextStyle textLogoStyle({required double fontSize}) {
  return TextStyle(
    color: const Color(0xff1e1f1e),
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
  );
}
