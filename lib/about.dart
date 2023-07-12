import 'package:flutter/material.dart';
import 'package:quran/constants_variables.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "About",
          ),
          backgroundColor: const Color.fromARGB(255, 56, 115, 59),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text('''Quran text taken from \n 
King Fahd Glorious Qur'an Printing Complex.
Website:  https://qurancomplex.gov.sa \n
File source: https://qurancomplex.gov.sa/en/techquran/dev/ \n
File: "Unicode Uthmanic Font (Hafs Narration)"'''),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                const Text(
                    '''Malayalam translation: Cheriyamundam Abdul Hameed & Kunji Mohammed Parappore.\n
Source: Fawaz Ahmed - https://github.com/fawazahmed0\n
File: https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/editions/mal-abdulhameedmada.json'''),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                TextButton.icon(
                  icon: Image.asset(
                    'assets/WhatsApp-PNG-Picture.png',
                    height: 50,
                  ),
                  onPressed: () async {
                    if (!await launchUrl(whatsAppUrl,
                        mode: LaunchMode.externalApplication)) {
                      throw 'Could not launch $whatsAppUrl';
                    }
                  },
                  label: const Text(
                    'Click to report any mistake. ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
