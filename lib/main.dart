import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: LoadingScreen(),
    );
  }
}
