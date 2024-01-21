import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:quran/constants_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndexController extends GetxController {
  @override
  Future<void> onInit() async {
    final newVersion = NewVersionPlus();
    newVersion.showAlertIfNecessary(context: Get.context!);

    final String response =
        await rootBundle.loadString('assets/hafs_smart_v8.json');
    final data = json.decode(response);

    arabicText = data['quran'];
    malayalamText = data['malayalam'];

    await getSettings();

    super.onInit();
  }

  List arabicText = [];
  List malayalamText = [];
  List quran = [];

  int bookmarkedAyah = 1;
  int bookmarkedSura = 1;
  bool fabIsClicked = false;

  readBookmark() async {
    final prefs = await SharedPreferences.getInstance();
    //prefs.clear();
    try {
      bookmarkedAyah = prefs.getInt('ayah')!;
      bookmarkedSura = prefs.getInt('surah')!;
      return true;
    } catch (e) {
      return false;
    }
  }
}
