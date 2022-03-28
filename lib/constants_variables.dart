// ignore_for_file: non_constant_identifier_names, await_only_futures

import 'package:shared_preferences/shared_preferences.dart';

Future getSettings() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    arabicFontSize = await prefs.getInt('arabicFontSize')!.toDouble();
    malayalamFontSize = await prefs.getInt('malayalamFontSize')!.toDouble();
    mushafFontSize = await prefs.getInt('mushafFontSize')!.toDouble();
  } catch (e) {
     arabicFontSize = 28;
     mushafFontSize = 40;
     malayalamFontSize = 15;
  }
}

String arabicFont = 'quran';
double malayalamFontSize = 15;
double arabicFontSize = 28;
double mushafFontSize = 40;

String Avoiceurl = 'https://play.google.com/store/apps/details?id=com.ahlussunna_voice';
String Awraadurl = 'https://play.google.com/store/apps/details?id=org.ahlussunnabooks.awraad';
String quranAppurl = 'https://play.google.com/store/apps/details?id=org.ahlussunnabooks.quran';
