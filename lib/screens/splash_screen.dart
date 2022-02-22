import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lojavirtual/screens/base/base_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        (MaterialPageRoute(builder: (_) => BaseScreen())),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
