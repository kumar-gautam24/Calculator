import 'dart:async';
import 'package:calculator/calculator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer( const Duration(
        seconds: 2,
        milliseconds: 600),
            () => Navigator.pushReplacement(context,
        MaterialPageRoute(
            builder: (context)=>const MyCalculator()
        ),
    ));
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Lottie.asset('assets/110167-calculator.json'),
          )
        ],
      ),

    );
  }
}
