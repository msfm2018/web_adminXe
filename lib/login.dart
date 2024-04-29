import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'home.dart';
import 'login_style.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  var isLoggingIn = false;
  var isButtonEnabled = false;

  var node = FocusScopeNode();

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            decoration: boxDecoration('assets/images/bg.jpg'),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Center(
                    child: FocusScope(
                      node: node,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 800,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '管理系统',
                                  style: titleStyle,
                                ),

                                const SizedBox(
                                  height: 40,
                                ),

                                TextField(
                                  autofocus: true,
                                  controller: usernameController,
                                  cursorColor: Colors.white,
                                  cursorWidth: 2,
                                  decoration: decorationStyle(usernameController, '请输入账号'),
                                  onEditingComplete: () => node.nextFocus(),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                TextField(
                                  controller: passwordController,
                                  decoration: decorationStyle(usernameController, '请输入密码'),
                                  maxLength: 18,
                                  cursorColor: Colors.white,
                                  cursorWidth: 2,
                                  obscureText: true,
                                  onEditingComplete: () => node.nextFocus(),
                                ),

                                //三方控件
                                FlutterPwValidator(
                                  controller: passwordController,
                                  minLength: 8,
                                  uppercaseCharCount: 2,
                                  numericCharCount: 3,
                                  // specialCharCount: 1,
                                  normalCharCount: 3,
                                  width: 400,
                                  height: 150,
                                  onSuccess: () {
                                    setState(() {
                                      isButtonEnabled = true;
                                    });
                                  },
                                  onFail: () {
                                    isButtonEnabled = false;
                                  },
                                ),

                                Container(
                                  height: 360,
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    width: 420,
                                    height: 50,
                                    child: TextButton(
                                      onPressed: isButtonEnabled ? handleLoginButtonPressed : null,
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.resolveWith((states) {
                                          if (states.contains(MaterialState.hovered)) {
                                            return const Color.fromARGB(255, 41, 103, 255);
                                          }
                                          return const Color.fromARGB(155, 41, 103, 255);
                                        }),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                                        ),
                                      ),
                                      child: Text('登录', style: loginTextStyle),
                                    ),
                                  ),
                                ),

                                if (isLoggingIn) const CircularProgressIndicator()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ))));
  }

  void handleLoginButtonPressed() {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      node.nextFocus();
    } else {
      setState(() {
        isLoggingIn = true;
      });

      Future.delayed(const Duration(seconds: 1));

      setState(() {
        isLoggingIn = false;
      });

      Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => const Home()),
        ModalRoute.withName('/'),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    node.dispose();
  }
}
