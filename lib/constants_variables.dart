// ignore_for_file: non_constant_identifier_names, await_only_futures

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future getSettings() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    arabicFontSize = await prefs.getInt('arabicFontSize')!.toDouble();
    malayalamFontSize = await prefs.getInt('malayalamFontSize')!.toDouble();
    mushafFontSize = await prefs.getInt('mushafFontSize')!.toDouble();
    numberSystem = (await prefs.getBool('numberSystem'))!;
    theme = (await prefs.getBool('theme'))!;
  } catch (e) {
    arabicFontSize = 28;
    mushafFontSize = 40;
    malayalamFontSize = 15;
    numberSystem = false;
    theme = false;
  }
  print(theme);
}

String arabicFont = 'quran';
double malayalamFontSize = 15;
double arabicFontSize = 28;
double mushafFontSize = 40;
bool numberSystem = false;
bool theme = false;

Uri Avoiceurl = Uri.parse(
    'https://play.google.com/store/apps/details?id=com.ahlussunna_voice');
Uri Awraadurl = Uri.parse(
    'https://play.google.com/store/apps/details?id=org.ahlussunnabooks.awraad');
Uri quranAppurl = Uri.parse(
    'https://play.google.com/store/apps/details?id=org.ahlussunnabooks.quran');
Uri whatsAppUrl = Uri.parse(
    'https://api.whatsapp.com/send?phone=919633645334&text=*Send%20from%20Quran%20App*%0A');

Uri duaFromQuranurl = Uri.parse(
    'https://play.google.com/store/apps/details?id=dev.najad.duasinquran');

Uri sunnahSouq = Uri.parse('https://sunnahsouq.in');
