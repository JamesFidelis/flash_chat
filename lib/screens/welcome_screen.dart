import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/extracts.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  var controller;
  var animate;

  @override
  void initState() {
    super.initState();
    AnimationController controllers =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    controller = controllers;

    Animation animated = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    animate = animated;

    controller.forward();

    controller.addListener(() {
      loadFire();
      setState(() {});
    });
  }

  void loadFire() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animate.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 80.0,
                  ),
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                      fontFamily: 'Dancing Script Bold',
                      fontSize: 70.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText('Flash Chat'),
                    ],
                    isRepeatingAnimation: true,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                title: 'Log In',
                color: Colors.lightBlueAccent,
                onPress: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                }),
            RoundedButton(
                title: 'Register',
                color: Colors.blueAccent,
                onPress: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                }),
          ],
        ),
      ),
    );
  }
}
