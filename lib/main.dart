import 'package:calculator/calculator.dart';
import 'package:calculator/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main()  {

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home:  const SplashScreen(),
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
    );
  }
}