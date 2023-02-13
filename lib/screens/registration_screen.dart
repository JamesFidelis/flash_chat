import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/extracts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  var Email, Password;
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
                    hintText: 'Enter Your Email'),
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
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Register',
                color: Colors.blueAccent,
                onPress: () async {
                  setState(() {
                    showProgress = true;
                  });
                  try {
                    var newUser = await _auth.createUserWithEmailAndPassword(
                        email: Email, password: Password);
                    if (newUser != null) {
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
