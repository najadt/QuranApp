import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:new_version_plus/new_version_plus.dart';
import 'constants_variables.dart';
import 'index.dart';

void main() {
  runApp(const MyApp());
}

List arabic = [];
List malayalam = [];
List quran = [];
// Fetch content from the json file
Future readJson() async {
  final String response =
      await rootBundle.loadString('assets/hafs_smart_v8.json');
  final data = await json.decode(response);

  arabic = data['quran'];
  malayalam = data['malayalam'];
  return quran = [arabic, malayalam];
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await readJson();
      await getSettings();
      //final newVersion = NewVersionPlus();
      //newVersion.showAlertIfNecessary(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const IndexPage(),
    );
  }
}
