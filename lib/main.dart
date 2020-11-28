import 'package:clima/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.black),
    );
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        accentColor: Colors.blue[500],
      ),
      home: LoadingScreen(),
    );
  }
}
