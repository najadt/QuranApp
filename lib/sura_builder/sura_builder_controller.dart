import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/index/index_controller.dart';
import 'package:quran/sura_names.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SuraController extends GetxController {
  @override
  void onInit() {
    sura = arguments[0];
    suraName = arguments[1];
    ayah = arguments[2];
    previousVerse();
    fullSura();
    super.onInit();
  }

@override
  void onReady() {
    jumbtoAyah();
    super.onReady();
  }

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  List arguments = Get.arguments;

  String fullSuraString = '';
  int previousVerses = 0;
  RxBool view = true.obs;

  List arabic = Get.find<IndexController>().arabicText;
  late int sura;
  late String suraName;
  late int ayah;
  List malayalam = Get.find<IndexController>().malayalamText;

  fullSura() {
    for (int i = 0; i < lenghtOfSura(); i++) {
      fullSuraString += (arabic[i + previousVerses]['aya_text']);
    }
  }

  previousVerse() {
    if (sura + 1 != 1) {
      for (int i = sura - 1; i >= 0; i--) {
        previousVerses = previousVerses + noOfVerses[i];
      }
    }
  }

  int lenghtOfSura() {
    return noOfVerses[sura];
  }

  //
  //               'sura': controller.bookmarkedSura - 1,
  //               'suraName': arabicName[controller.bookmarkedSura - 1]['name'],
  //               'ayah': controller.bookmarkedAyah,
  //

  jumbtoAyah() {
    if (Get.find<IndexController>().fabIsClicked) {
      itemScrollController.scrollTo(
          index: ayah,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOutCubic);
    }
    Get.find<IndexController>().fabIsClicked = false;
  }
}
