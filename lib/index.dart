import 'package:flutter/material.dart';
import 'constants_variables.dart';
import 'sura_builder.dart';
import 'main.dart';
import 'sura_names.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer.dart';
import 'to_arabic_no_converter.dart';

int bookmarkedAyah = 1;
int bookmarkedSura = 1;
bool fabIsClicked = false;

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  readBookmark() async {
    final prefs = await SharedPreferences.getInstance();
    //prefs.clear();
    try {
      bookmarkedAyah = prefs.getInt('ayah')!;
      bookmarkedSura = prefs.getInt('surah')!;
      //print(bookmarkedSura);
      //print(bookmarkedAyah);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Go to bookmark',
        child: const Icon(Icons.bookmark),
        backgroundColor: Colors.green,
        onPressed: () async {
          fabIsClicked = true;
          if (await readBookmark() == true) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SuraBuilder(
                          arabic: quran[0],
                          sura: bookmarkedSura - 1,
                          suraName: arabicName[bookmarkedSura - 1]['name'],
                          ayah: bookmarkedAyah,
                          malayalam: quran[1],
                        )));
          }
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          //"القرآن",
          "Quran",
          style: TextStyle(
              //fontFamily: 'quran',
              fontSize: 35,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(1, 1),
                  blurRadius: 2.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ]),
        ),
        backgroundColor: const Color.fromARGB(255, 56, 115, 59),
      ),
      body: FutureBuilder(
        future: readJson(),
        builder: (
          BuildContext context,
          AsyncSnapshot snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              return indexCreator(snapshot.data, context);
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }

  Container indexCreator(quran, context) {
    return Container(
      color: const Color.fromARGB(255, 221, 250, 236),
      child: ListView(
        children: [
          for (int i = 0; i < 114; i++)
            Container(
              color: i % 2 == 0
                  ? const Color.fromARGB(255, 253, 247, 230)
                  : const Color.fromARGB(255, 253, 251, 240),
              child: TextButton(
                child: Row(
                  children: [
                    numberSystem
                        ? ArabicSuraNumbers(i: i)
                        : Text(
                            "${i + 1}",
                            style: const TextStyle(
                              color: Colors.black,
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
                          Text(
                            suraNamesMalayalam[i],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                          Row(
                            children: [
                              Text(englishName[i]['Name'],
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.black45)),
                              const SizedBox(
                                width: 5,
                              ),
                              englishName[i]['Maccan / Medinan'] == 'Maccan'
                                  ? Image.asset(
                                      'assets/makka.png',
                                      width: 10,
                                    )
                                  : Image.asset(
                                      'assets/madeena.png',
                                      width: 12,
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Row(
                      children: [
                        Text(
                          arabicName[i]['name'],
                          style: const TextStyle(
                              fontSize: 30,
                              color: Colors.black87,
                              fontFamily: 'quran',
                              shadows: [
                                Shadow(
                                  offset: Offset(.5, .5),
                                  blurRadius: 1.0,
                                  color: Color.fromARGB(255, 130, 130, 130),
                                )
                              ]),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ArabicSuraNumbers(i: i)
                      ],
                    ),
                  ],
                ),
                onPressed: () {
                  fabIsClicked = false;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SuraBuilder(
                              arabic: quran[0],
                              sura: i,
                              suraName: arabicName[i]['name'],
                              malayalam: quran[1],
                              ayah: 0,
                            )),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class ArabicSuraNumbers extends StatelessWidget {
  const ArabicSuraNumbers({
    Key? key,
    required this.i,
  }) : super(key: key);

  final int i;

  @override
  Widget build(BuildContext context) {
    return Text(
      '\uFD3E' + (i + 1).toString().toArabicNumbers + '\uFD3F',
      style: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontFamily: 'me_quran',
          fontSize: 18,
          shadows: [
            Shadow(
              offset: Offset(.5, .5),
              blurRadius: 1.0,
              color: Colors.amberAccent,
            ),
          ]),
    );
  }
}
