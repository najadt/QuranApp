import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/sura_builder/sura_builder_controller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:quran/return_arabic_number_with_style.dart';

import '../constants_variables.dart';

class SuraBuilder extends GetView<SuraController> {
  const SuraBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    //print(widget.sura);
    //print(LengthOfSura);
    Get.put(SuraController());

    return Scaffold(
      appBar: AppBar(
        leading: Tooltip(
          message: 'Mushaf Mode',
          child: TextButton(
            child: const Icon(
              Icons.chrome_reader_mode,
              color: Colors.white,
            ),
            onPressed: () {
              controller.view.toggle();
            },
          ),
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ArabicSuraNumbers(
              i: controller.sura,
              //color: Colors.white,
              size: 21,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              controller.suraName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'quran',
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 2.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ]),
            ),
            const SizedBox(
              width: 25,
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 56, 115, 59),
      ),
      body: SingleSura(controller: controller),
    );
  }
}

class ReturnBasmala extends StatelessWidget {
  const ReturnBasmala({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: Text(
          'بسم الله الرحمن الرحيم',
          style: TextStyle(
              fontFamily: 'me_quran',
              fontSize: 30,
              color: Theme.of(context).colorScheme.onBackground),
          textDirection: TextDirection.rtl,
        ),
      ),
    ]);
  }
}

class SingleSura extends StatelessWidget {
  const SingleSura({super.key, required this.controller});

  final SuraController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: Theme.of(context).colorScheme.primary,
          child: controller.view.value
              ? ScrollablePositionedList.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        (index != 0) ||
                                (controller.sura == 0) ||
                                (controller.sura == 8)
                            ? const Text('')
                            : const ReturnBasmala(),
                        Container(
                          color: index % 2 != 0
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.primary,
                          child: PopupMenuButton(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: verseBuilder(
                                    index, controller.previousVerses, context),
                              ),
                              itemBuilder: (context) => [
                                    PopupMenuItem(
                                      onTap: () {
                                        savebookmark(
                                            controller.sura + 1, index);
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(
                                            Icons.bookmark_add,
                                            color: Color.fromARGB(
                                                255, 56, 115, 59),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('Bookmark'),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        String arabic = controller.arabic[
                                                index +
                                                    controller.previousVerses]
                                            ['aya_text'];
                                        // ignore: prefer_interpolation_to_compose_strings
                                        Share.share(arabic.substring(
                                                0, arabic.length - 1) +
                                            '\n\n' +
                                            controller.malayalam[index +
                                                    controller.previousVerses]
                                                ['text'] +
                                            '\n\n' +
                                            ('(Quran ${controller.sura + 1}:${index + 1})'));
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(
                                            Icons.share,
                                            color: Color.fromARGB(
                                                255, 56, 115, 59),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('Share'),
                                        ],
                                      ),
                                    ),
                                  ]),
                        ),
                      ],
                    );
                  },
                  itemScrollController: controller.itemScrollController,
                  itemPositionsListener: controller.itemPositionsListener,
                  itemCount: controller.lenghtOfSura(),
                )
              : ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              controller.sura + 1 != 1 &&
                                      controller.sura + 1 != 9
                                  ? const ReturnBasmala()
                                  : const Text(''),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  controller.fullSuraString, //mushaf mode
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: mushafFontSize,
                                    fontFamily: arabicFont,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ));
  }

  Future savebookmark(surah, ayah) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('surah', surah);
    await prefs.setInt('ayah', ayah);
    //print(surah);
    //print(ayah);
  }

  Row verseBuilder(int index, int previousVerses, context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                controller.arabic[index + previousVerses]['aya_text'],
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: arabicFontSize,
                  fontFamily: arabicFont,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    controller.malayalam[index + previousVerses]['text'] +
                        ' ' +
                        '(' +
                        (index + 1).toString() +
                        ')',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontFamily: 'malayalam',
                      height: 1.5,
                      fontSize: malayalamFontSize,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
