import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/login_page_widgets.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
              SizedBox(
                height: double.infinity,
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
                      Text(
                        'SignUp',
                        textAlign: TextAlign.center,
                        style: textLogoStyle(fontSize: 40.0),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Login',
                            hintText: 'Will be used as username',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(labelText: 'Password')),
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
                          child: buildLoginBtn(
                              onPressed: () {}, buttonText: 'Create Account')),
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
                        icon: Icon(Icons.arrow_back_ios_sharp)),
                    questionSignUp(context: context)
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
