import 'package:flutter/material.dart';
import 'package:plasteringtimer/pages/home.dart';
import 'package:plasteringtimer/pages/wall_timer.dart';

void main() => runApp(MaterialApp(
  title: 'Plastering Timer',
  theme: new ThemeData(scaffoldBackgroundColor: Colors.blueAccent),
  initialRoute: '/',
  routes: {
    '/': (context) => Home(),
    '/wall': (context) => WallTimer(),
  }
));