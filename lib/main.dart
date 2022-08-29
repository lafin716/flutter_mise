import 'package:flutter/material.dart';
import 'package:flutter_mise/screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'sunflower',
      ),
      home: HomeScreen(),
    ),
  );
}
