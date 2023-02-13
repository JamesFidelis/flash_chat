import 'package:flutter/material.dart';
import 'package:flash_chat/components/extracts.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var Email, Password;
  final _auth = FirebaseAuth.instance;
  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showProgress,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: kTextFieldTextColor,
                onChanged: (value) {
                  String email = value;
                  Email = email;
                },
                decoration: kTextFieldDecorations.copyWith(
                    hintText: 'Enter your Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                textAlign: TextAlign.center,
                style: kTextFieldTextColor,
                onChanged: (value) {
                  String password = value;
                  Password = password;
                },
                decoration: kTextFieldDecorations.copyWith(
                    hintText: 'Enter your Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  title: 'Log In',
                  color: Colors.lightBlueAccent,
                  onPress: () async {
                    setState(() {
                      showProgress = true;
                    });
                    try {
                      var myUser = await _auth.signInWithEmailAndPassword(
                          email: Email, password: Password);
                      if (myUser != null) {
                        emailController.clear();
                        passwordController.clear();
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        showProgress = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                    setState(() {
                      showProgress = false;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
