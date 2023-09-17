import 'package:flutter/material.dart';
import 'package:pertemuanempat/about.dart';
import 'package:pertemuanempat/countdown.dart';
import 'package:pertemuanempat/login_screen.dart';
import 'package:pertemuanempat/navbar.dart';
import 'package:pertemuanempat/stopwatch.dart';

void main() => runApp(StopwatchApp());

class StopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NavBar(),
    );
  }
}