import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/login_page_widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  // bool _rememberMe = false;

  /*Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }*/

  /*Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }*/

  /*Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }*/

  /*Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }*/

  /* Widget _buildSocialBtn(
      {required Function() onTap, required AssetImage logo}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }*/

  /*Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            onTap: () => print('Login with Facebook'),
            logo: AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
            onTap: () => print('Login with Google'),
            logo: AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
        ],
      ),
    );
  }*/

  late TextEditingController _loginController;

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
  }

  @override
  void dispose() {
    _loginController.dispose();
    super.dispose();
  }

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
                      child: buildLoginBtn(
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
                    buildSignupBtn(onPressed: () {
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

class SecondLoginPage extends StatelessWidget {
  const SecondLoginPage({Key? key}) : super(key: key);

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
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          autofocus: true,
                          decoration: InputDecoration(labelText: 'Login'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            decoration: InputDecoration(labelText: 'Password')),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Hero(
                          tag: 'login_button',
                          child: buildLoginBtn(
                              onPressed: () {}, buttonText: 'Sign In')),
                      const SizedBox(
                        height: 70,
                      ),
                      buildSignupBtn(onPressed: () {
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
                    icon: Icon(Icons.arrow_back_ios_sharp)),
              ),
              //_buildSignupBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
