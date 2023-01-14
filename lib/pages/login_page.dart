import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/login_page_widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
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
            SafeArea(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    Text(
                      'Card\nExam',
                      textAlign: TextAlign.center,
                      style: textLogoStyle(fontSize: 80.0),
                    ),
                    const Spacer(),
                    Hero(
                      tag: 'login_button',
                      child: BuildLoginBtn(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          buttonText: 'LOGIN'),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      '- OR -',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Сontinue as guest',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    BuildSignUpBtn(onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                      //Navigator.pushNamed(context, '/test');
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondLoginPage extends StatefulWidget {
  const SecondLoginPage({Key? key}) : super(key: key);

  @override
  State<SecondLoginPage> createState() => _SecondLoginPageState();
}

class _SecondLoginPageState extends State<SecondLoginPage> {
  late TextEditingController _loginController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
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
                        'Card\nExam',
                        textAlign: TextAlign.center,
                        style: textLogoStyle(fontSize: 40.0),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                          controller: _loginController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          autofocus: true,
                          decoration: const InputDecoration(labelText: 'Login'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                            controller: _passwordController,
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            onSubmitted: (value) => print('SIGNIN'),
                            decoration:
                                const InputDecoration(labelText: 'Password')),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Hero(
                          tag: 'login_button',
                          child: BuildLoginBtn(
                              onPressed: () => print('SIGNIN'),
                              buttonText: 'Sign In')),
                      const SizedBox(
                        height: 70,
                      ),
                      BuildSignUpBtn(onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      }),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: IconButton(
                    alignment: Alignment.topLeft,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_sharp)),
              ),
              //_buildSignupBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
