import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';


class AppThemes {
  static final appThemeData = {
    // AppTheme.DartTheme: ThemeData(
    //   brightness: Brightness.dark,
    //   useMaterial3: true,
    //   textTheme: textTheme,
    //   dividerColor: const Color(0xff51669e),
    //   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    //     backgroundColor: Color(0xff3a4d7f),
    //     elevation: 1,
    //     unselectedItemColor: Color(0xff51669e),
    //     selectedItemColor: Colors.white,
    //   ),
    //   elevatedButtonTheme: ElevatedButtonThemeData(
    //     style: ButtonStyle(
    //         backgroundColor: MaterialStateProperty.all(
    //           const Color(0xff51669e),
    //         ),
    //         foregroundColor: MaterialStateProperty.all(Colors.white)),
    //   ),
    //   drawerTheme: const DrawerThemeData(
    //       backgroundColor: Color(0xff3a4d7f), surfaceTintColor: Colors.white),
    //   colorScheme: ColorScheme(
    //     background: const Color(0xff21325b), // background
    //     onBackground: const Color(0xff51669e),
    //     primary: const Color(0xff4671c6), //button
    //     onPrimary: Colors.white, // text on button
    //     brightness: Brightness.dark,
    //     secondary: const Color(0xff0f4e5a),
    //     onSecondary: Colors.white,
    //     error: Colors.red.shade400,
    //     onError: Colors.red,
    //     surface: const Color(0xff3a4d7f), //appbar
    //     onSurface: Colors.white, //text
    //   ),
    // ),
    AppTheme.LightTheme: ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      textTheme: textTheme,
      dividerTheme: const DividerThemeData(color: colorF2F5FF, thickness: 1),
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(backgroundColor: transparent),
      // drawerTheme: const DrawerThemeData(
      //     backgroundColor: Colors.white, surfaceTintColor: Colors.black),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
          linearTrackColor: secondary,
          circularTrackColor: secondary,
          color: white),

      colorScheme: ColorScheme(
        background: white, // background
        onBackground: colorA8B1CE,
        primary: primary, //button
        onPrimary: white, // text on button
        brightness: Brightness.light,
        secondary: secondary,
        onSecondary: white,
        error: Colors.red.shade400,
        onError: Colors.red,
        surface: white, //appbar
        onSurface: color1F1F1F, //text
      ),
    )
  };
}
