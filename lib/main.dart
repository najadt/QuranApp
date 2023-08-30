import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:new_version_plus/new_version_plus.dart';
import 'constants_variables.dart';
import 'index.dart';
//import 'package:new_version/new_version.dart';

void main() {
  runApp(const MyApp());
}

List arabic = [];
List malayalam = [];
List quran = [];
List quranTextForSharing = [];
// Fetch content from the json file
Future readJson() async {
  final String response =
      await rootBundle.loadString('assets/hafs_smart_v8.json');
  final data = await json.decode(response);

  final String response2 =
      await rootBundle.loadString('assets/hafsData_v18.json');
  final dataForSharing = await json.decode(response2);

  quranTextForSharing = dataForSharing['quran'];
  arabic = data['quran'];
  malayalam = data['malayalam'];
  return quran = [arabic, malayalam, quranTextForSharing];
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
      //final newVersion = NewVersion();
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
