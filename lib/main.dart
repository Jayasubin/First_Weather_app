import 'package:flutter/material.dart';

import 'home_timed.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      //theme: ThemeData(
      //primarySwatch: Colors.green,
      //visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      home: HomePage(),
    );
  }
}
