import 'package:flutter/material.dart';

import '../utilities/constants.dart';

Widget buildSignupBtn({required Function() onPressed}) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      padding: const EdgeInsets.only(bottom: 50),
      child: GestureDetector(
        onTap: () => onPressed(),
        child: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Don\'t have an Account? ',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Sign Up',
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
    ),
  );
}

Widget buildLoginBtn(
    {required Function() onPressed, required String buttonText}) {
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

Widget questionSignUp({required BuildContext context}) {
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
                      'Если вашего учебного заведения нет в списке, напишите нам на почту CardExam.yandex.ru'),
                ),
                ListTile(
                  title: Text('Что даёт регистрация?'),
                  subtitle: Text(
                      'Если вашего учебного заведения нет в списке, напишите нам на почту CardExam.yandex.ru'),
                ),
                ListTile(
                  title: Text('Вопрос 3'),
                  subtitle: Text(
                      'Если вашего учебного заведения нет в списке, напишите нам на почту CardExam.yandex.ru'),
                ),
                ListTile(
                  title: Text('Вопрос 4'),
                  subtitle: Text(
                      'Если вашего учебного заведения нет в списке, напишите нам на почту CardExam.yandex.ru'),
                ),
                ListTile(
                  title: Text('Вопрос 5'),
                  subtitle: Text(
                      'Если вашего учебного заведения нет в списке, напишите нам на почту CardExam.yandex.ru'),
                ),
              ],
            );
          },
        );
      },
      icon: const Icon(Icons.question_mark));
}

TextStyle textLogoStyle({required double fontSize}) {
  return TextStyle(
    color: const Color(0xff1e1f1e),
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
  );
}
