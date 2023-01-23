import 'package:cardexam/theme/theme_constants.dart';
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

TextStyle textLogoStyle({required double fontSize}) => TextStyle(
      color: const Color(0xff1e1f1e),
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
