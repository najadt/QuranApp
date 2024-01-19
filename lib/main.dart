import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/theme/theme.dart';
//import 'package:new_version_plus/new_version_plus.dart';
import 'index/index.dart';

void main() {
  runApp(const MyApp());
}

// Fetch content from the json file

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quran',
      theme: lightMode,
      darkTheme: darkmode,
      themeMode: ThemeMode.system,
      home: const IndexPage(),
    );
  }
}
