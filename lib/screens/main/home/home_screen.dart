import 'package:flutter/material.dart';
import 'package:healthline/res/colors.dart';
import 'package:healthline/res/dimens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        color: color1F1F1F,
        child: Container(
          height: dimensHeight() * 30,
          width: dimensHeight()*30,
          color: colorA8B1CE,
        ),
      ),
    );
  }
}
