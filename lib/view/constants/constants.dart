// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

Color lightblue = Color(0xff64e9ff).withOpacity(0.8);

List<IconData> icons = [
  Icons.straight,
  Icons.repeat_one_on,
  Icons.repeat_on,
  Icons.shuffle_on,
];
TextTheme TEXT_THEME_DEFAULT = const TextTheme(
  headline4:
      TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
  headline5:
      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
  headline6: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  ),
  bodyText1:
      TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 10),
  bodyText2:
      TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 8),
);

TextTheme TEXT_THEME_DARK = const TextTheme(
  headline4:
      TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
  headline5:
      TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
  headline6: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  ),
  bodyText1:
      TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 10),
  bodyText2:
      TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 8),
);

BoxDecoration background(BuildContext context) {
  return BoxDecoration(
    gradient: LinearGradient(colors: [
      Theme.of(context).primaryColor.withOpacity(0.8),
      Theme.of(context).colorScheme.secondary.withOpacity(0.8),
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
  );
}

BoxDecoration shaderDecoration(
    BuildContext context, Color? primary, Color? secondary) {
  return BoxDecoration(
    gradient: LinearGradient(colors: [
      primary ?? Theme.of(context).primaryColor.withOpacity(0.9),
      secondary ?? Theme.of(context).colorScheme.secondary.withOpacity(0.9),
    ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
  );
}
