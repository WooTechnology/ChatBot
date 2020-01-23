import 'dart:async';
import 'package:eliana_chatbot/router.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/photo5.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
    ));
  }

  startTimer() {
    var _duration = Duration(milliseconds: 1500);
    return Timer(_duration, navigate);
  }

  navigate() async {
    Navigator.of(context).pushReplacementNamed(home_page);
  }
}
