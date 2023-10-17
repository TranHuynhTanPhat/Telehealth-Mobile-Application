import 'package:flutter/material.dart';
import 'package:healthline/utils/log_data.dart';

class SizeConfig {
  double _screenWidth = 0;
  double _screenHeight = 0;
  double _blockWidth = 0;
  double _blockHeight = 0;

  static double textMultiplier = 0;
  static double imageSizeMultiplier = 0;
  static double heightMultiplier = 0;
  static double widthMultiplier = 0;

//  void init(BuildContext context) {
//     _screenWidth = MediaQuery.of(context).size.width;
//     _screenHeight = MediaQuery.of(context).size.width;
  void init(BoxConstraints constraints) {
    _screenWidth = constraints.maxWidth;
    _screenHeight = constraints.maxHeight;
    logPrint("$_screenWidth $_screenHeight");
    _blockWidth = _screenWidth / 50.5854791898;
    _blockHeight = _screenHeight / 112.4121759774;
    logPrint('$_blockWidth $_blockHeight');
    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;
  }
}

double maxWidth() => SizeConfig.widthMultiplier * 50.5854791898;
double dimensWidth() => SizeConfig.widthMultiplier;
double dimensHeight() => SizeConfig.heightMultiplier;
double dimensText() => SizeConfig.textMultiplier;
double dimensImage() => SizeConfig.imageSizeMultiplier;
double dimensIcon() => SizeConfig.widthMultiplier * 4;

class Converts {
  static double c8 = 1 * SizeConfig.textMultiplier;
  static double c11 = 1.375 * SizeConfig.textMultiplier;
  static double c12 = 1.5 * SizeConfig.textMultiplier;
  static double c14 = 1.75 * SizeConfig.textMultiplier;
  static double c16 = 2 * SizeConfig.textMultiplier;
  static double c20 = 2.5 * SizeConfig.textMultiplier;
  static double c24 = 3 * SizeConfig.textMultiplier;
  static double c28 = 3.5 * SizeConfig.textMultiplier;
  static double c32 = 4 * SizeConfig.textMultiplier;
  static double c36 = 4.5 * SizeConfig.textMultiplier;
  static double c40 = 5 * SizeConfig.textMultiplier;
  static double c48 = 6 * SizeConfig.textMultiplier;
  static double c56 = 7 * SizeConfig.textMultiplier;
  static double c64 = 8 * SizeConfig.textMultiplier;
  static double c72 = 9 * SizeConfig.textMultiplier;
  static double c80 = 10 * SizeConfig.textMultiplier;
  static double c88 = 11 * SizeConfig.textMultiplier;
  static double c96 = 12 * SizeConfig.textMultiplier;
  static double c104 = 13 * SizeConfig.textMultiplier;
  static double c112 = 14 * SizeConfig.textMultiplier;
  static double c120 = 15 * SizeConfig.textMultiplier;
  static double c128 = 16 * SizeConfig.textMultiplier;
  static double c136 = 17 * SizeConfig.textMultiplier;
  static double c144 = 18 * SizeConfig.textMultiplier;
  static double c152 = 19 * SizeConfig.textMultiplier;
  static double c160 = 20 * SizeConfig.textMultiplier;
  static double c168 = 21 * SizeConfig.textMultiplier;
  static double c176 = 22 * SizeConfig.textMultiplier;
  static double c184 = 23 * SizeConfig.textMultiplier;
  static double c192 = 24 * SizeConfig.textMultiplier;
  static double c200 = 25 * SizeConfig.textMultiplier;
  static double c208 = 26 * SizeConfig.textMultiplier;
  static double c216 = 27 * SizeConfig.textMultiplier;
  static double c224 = 28 * SizeConfig.textMultiplier;
  static double c232 = 29 * SizeConfig.textMultiplier;
  static double c240 = 30 * SizeConfig.textMultiplier;
  static double c248 = 31 * SizeConfig.textMultiplier;
  static double c256 = 32 * SizeConfig.textMultiplier;
  static double c264 = 33 * SizeConfig.textMultiplier;
  static double c272 = 34 * SizeConfig.textMultiplier;
  static double c280 = 35 * SizeConfig.textMultiplier;
  static double c288 = 36 * SizeConfig.textMultiplier;
  static double c296 = 37 * SizeConfig.textMultiplier;
  static double c304 = 38 * SizeConfig.textMultiplier;
  static double c312 = 39 * SizeConfig.textMultiplier;
  static double c320 = 40 * SizeConfig.textMultiplier;
  static double c350 = 50 * SizeConfig.textMultiplier;
}
