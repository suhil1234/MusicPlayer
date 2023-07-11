import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import '../../view/constants/constants.dart';

class Themes {
  List<ThemeData> themes = [
    ThemeData(
      primaryColor: const Color(0xff103ce7),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xff64e9ff), brightness: Brightness.dark),
      //textTheme: TEXT_THEME_DEFAULT,
      //splashColor: Colors.white
    ),
    ThemeData(
      primaryColor: const Color(0xff018FA6),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xffAD6CA5), brightness: Brightness.dark),
      // textTheme: TEXT_THEME_DEFAULT,
      //splashColor: Colors.white
    ),
    ThemeData(
      //primaryColor: const Color(0xff134E5E),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xff71B280), brightness: Brightness.dark),
      primaryColor: const Color(0xff134E5E),
      brightness: Brightness.dark,

      //textTheme: TEXT_THEME_DARK,
      //splashColor: Colors.black,
    ),
  ];

  List<String> names = ['Mojito', 'violet', 'Moss', 'pinky'];
}
