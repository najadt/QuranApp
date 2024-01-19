import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  appBarTheme: const AppBarTheme(backgroundColor: Colors.green),
  colorScheme: const ColorScheme.light(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 253, 247, 230),
    onPrimary: Colors.black,
    secondary: Color.fromARGB(255, 253, 251, 240),
    onSecondary: Colors.black,
    background: Color.fromARGB(255, 253, 251, 240),
    onBackground: Colors.black,
  ),
);

ThemeData darkmode = ThemeData(
  appBarTheme:
      const AppBarTheme(backgroundColor: Color.fromARGB(255, 28, 64, 29)),
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    primary: Colors.grey.shade900,
    secondary: const Color.fromARGB(255, 39, 39, 39),
    background: Colors.grey.shade900,
    onBackground: Colors.grey.shade400,
    onSecondary: Colors.grey.shade400,
    onPrimary: Colors.grey.shade400,
  ),
);




//  ? const Color.fromARGB(255, 253, 247, 230)
//                   : const Color.fromARGB(255, 253, 251, 240),