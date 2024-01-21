import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quran/index/index_controller.dart';
import 'package:quran/return_arabic_number_with_style.dart';

import '../constants_variables.dart';
import '../drawer.dart';
import '../sura_builder/sura_builder.dart';
import '../sura_names.dart';

class IndexPage extends GetView<IndexController> {
  const IndexPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(IndexController());
    return Scaffold(
      drawer: const MyDrawer(),
      floatingActionButton: FAB(controller: controller),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          //"القرآن",
          "Quran",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, shadows: [
            Shadow(
              offset: Offset(1, 1),
              blurRadius: 2.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ]),
        ),
        //backgroundColor: const Color.fromARGB(255, 56, 115, 59),
      ),
      body: Index(controller: controller),
    );
  }
}

class FAB extends StatelessWidget {
  const FAB({
    super.key,
    required this.controller,
  });

  final IndexController controller;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Go to bookmark',
      onPressed: () async {
        controller.fabIsClicked = true;
        if (await controller.readBookmark() == true) {
          Get.to(() => const SuraBuilder(), arguments: [
            controller.bookmarkedSura - 1,
            arabicName[controller.bookmarkedSura - 1]['name'],
            controller.bookmarkedAyah,
          ]);
        }
      },
      child: const Icon(Icons.bookmark),
    );
  }
}

class Index extends StatelessWidget {
  const Index({
    super.key,
    required this.controller,
  });

  final IndexController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...List.generate(
          114,
          (index) => Container(
            color: index % 2 == 0
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
            child: TextButton(
              child: Row(
                children: [
                  Text(
                    "${index + 1}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      //fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MalayalamName(index: index),
                        EnglishNameWithIcon(index: index),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  ArabicNameWithNo(index: index),
                ],
              ),
              onPressed: () {
                controller.fabIsClicked = false;
                Get.to(() => const SuraBuilder(), arguments: [
                  index,
                  arabicName[index]['name'],
                  0,
                ]);
              },
            ),
          ),
        )
      ],
    );
  }
}

class ArabicNameWithNo extends StatelessWidget {
  const ArabicNameWithNo({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          arabicName[index]['name'],
          style: TextStyle(
            fontSize: 30,
            color: Theme.of(context).colorScheme.onBackground,
            fontFamily: arabicFont,
          ),
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(
          width: 10,
        ),
        ArabicSuraNumbers(i: index)
      ],
    );
  }
}

class MalayalamName extends StatelessWidget {
  const MalayalamName({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Text(
      suraNamesMalayalam[index],
      style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground, fontSize: 15),
    );
  }
}

class EnglishNameWithIcon extends StatelessWidget {
  const EnglishNameWithIcon({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(englishName[index]['Name'],
            style: TextStyle(
                fontSize: 10,
                color: Theme.of(context).colorScheme.onBackground)),
        const SizedBox(
          width: 5,
        ),
        englishName[index]['Maccan / Medinan'] == 'Maccan'
            ? Image.asset(
                'assets/makka.png',
                width: 10,
              )
            : Image.asset(
                'assets/madeena.png',
                width: 12,
              ),
      ],
    );
  }
}
