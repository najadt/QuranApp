// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variab, must_be_immutable, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'sura_names.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants_variables.dart';

final ItemScrollController itemScrollController = ItemScrollController();
final ItemPositionsListener itemPositionsListener =
    ItemPositionsListener.create();

class SuraBuilder extends StatefulWidget {
  final sura;
  final arabic;
  final suraName;
  final malayalam;
  final arabicTextForShareing;
  int ayah;

  SuraBuilder(
      {Key? key,
      this.sura,
      this.arabic,
      this.suraName,
      this.malayalam,
      this.arabicTextForShareing,
      required this.ayah, })
      : super(key: key);

  @override
  State<SuraBuilder> createState() => _SuraBuilderState();
}

class _SuraBuilderState extends State<SuraBuilder> {
  bool view = true;

  @override
  dispose() {
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => jumbtoAyah());
    super.initState();
  }

  jumbtoAyah() {
    if (fabIsClicked) {
      itemScrollController.scrollTo(
          index: widget.ayah,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOutCubic);
    }
    fabIsClicked = false;
  }

  @override
  Widget build(BuildContext context) {
    int LengthOfSura = noOfVerses[widget.sura];
    //print(widget.sura);
    //print(LengthOfSura);

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: Scaffold(
        appBar: AppBar(
          // flexibleSpace: Image(
          // image: AssetImage('assets/surahBackground.png')),
          // actions: [
          //   TextButton(
          //     child: const Icon(
          //       Icons.chrome_reader_mode,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       nextSurah(context, LengthOfSura);
          //     },
          //   ),
          // ],
          leading: Tooltip(
            message: 'Mushaf Mode',
            child: TextButton(
              child: const Icon(
                Icons.chrome_reader_mode,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  view = !view;
                });
              },
            ),
          ),
          centerTitle: true,
          title: Text(
            // widget.
            widget.suraName,
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
          backgroundColor: const Color.fromARGB(255, 56, 115, 59),
          //actions: [
          //   IconButton(
          //       onPressed: ()async {

          //           int result = await audioPlayer.play('https://najad.biz/QuranAudioFiles/69.mp3');
          //           if (result == 1) {
          //             print('success');
          //           }
          //           else{
          //             print('failed');
          //           }

          //       },
          //       icon: Icon(Icons.play_arrow))
          // ],
        ),
        body: SingleSuraBuilder(LengthOfSura),
      ),
    );
  }

  SafeArea SingleSuraBuilder(LenghtOfSura) {
    String fullSura = '';

    int previousVerses = 0;
    if (widget.sura + 1 != 1) {
      for (int i = widget.sura - 1; i >= 0; i--) {
        previousVerses = previousVerses + noOfVerses[i];
      }
    }
    // print('${widget.sura} surah no.');
    // print(previousVerses);

    if (!view)
      // ignore: curly_braces_in_flow_control_structures
      for (int i = 0; i < LenghtOfSura; i++) {
        fullSura += (widget.arabic[i + previousVerses]['aya_text']);
      }

    return SafeArea(
      child: Container(
        color: const Color.fromARGB(255, 253, 251, 240),
        child: view
            ? ScrollablePositionedList.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      (index != 0) || (widget.sura == 0) || (widget.sura == 8)
                          ? const Text('')
                          : const ReturnBasmala(),
                      Container(
                        color: index % 2 != 0
                            ? const Color.fromARGB(255, 253, 251, 240)
                            : const Color.fromARGB(255, 253, 247, 230),
                        child: PopupMenuButton(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: verseBuilder(index, previousVerses),
                            ),
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                    onTap: () {
                                      savebookmark(widget.sura + 1, index);
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.bookmark_add,
                                          color:
                                              Color.fromARGB(255, 56, 115, 59),
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
                                      Share.share(widget.arabicTextForShareing[index +
                                              previousVerses]['aya_text'] +
                                          '\n\n' +
                                          widget.malayalam[
                                              index + previousVerses]['text'] +
                                          '\n\n' +
                                          ('(Quran ${widget.sura + 1}:${index + 1})'));
                                    },
                                    child: const Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          Icons.share,
                                          color:
                                              Color.fromARGB(255, 56, 115, 59),
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
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
                itemCount: LenghtOfSura,
              )
            : ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            widget.sura + 1 != 1 && widget.sura + 1 != 9
                                ? const ReturnBasmala()
                                : const Text(''),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                fullSura, //mushaf mode
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: mushafFontSize,
                                  fontFamily: arabicFont,
                                  color: const Color.fromARGB(196, 44, 44, 44),
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
      ),
    );
  }

  Row verseBuilder(int index, previousVerses) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.arabic[index + previousVerses]['aya_text'],
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: arabicFontSize,
                  fontFamily: arabicFont,
                  color: const Color.fromARGB(196, 0, 0, 0),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.malayalam[index + previousVerses]['text'] +
                        ' ' +
                        '(' +
                        (index + 1).toString() +
                        ')',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black87,
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

  Future savebookmark(surah, ayah) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('surah', surah);
    await prefs.setInt('ayah', ayah);
    //print(surah);
    //print(ayah);
  }

  // void nextSurah(Context, len) {
  //   // Navigator.pop(Context);
  //   setState(() {
  //     SingleSuraBuilder(len + 1);
  //   });
  // }
}

class ReturnBasmala extends StatelessWidget {
  const ReturnBasmala({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Stack(children: [
      Center(
        child: Text(
          'بسم الله الرحمن الرحيم',
          style: TextStyle(fontFamily: 'me_quran', fontSize: 30),
          textDirection: TextDirection.rtl,
        ),
      ),
    ]);
  }
}
