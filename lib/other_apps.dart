// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants_variables.dart';

class OtherApps extends StatelessWidget {
  const OtherApps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Other Apps",
          ),
          backgroundColor: const Color.fromARGB(255, 56, 115, 59),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ElevatedButton(
                  style: const ButtonStyle(
                    //backgroundColor: Color(Colors.white),
                  ),
                  onPressed: AvoiceURL,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child:  Text(
                            'Ahlussunna Voice',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/ahlussunna_voice_logo.jpg',
                              height: 80,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Expanded(
                              child:  Text(
                                  '''ഡൗൺലോഡ് ചെയ്യാതെ തന്നെ അഹ്‌ലുസ്സുന്ന ദാഇമാരുടെ, വ്യത്യസ്ത വിഷയങ്ങളിലുള്ള പഠനാർഹമായ ക്ലാസുകളും ദർസുകളും കേൾക്കാൻ ഈ ആപ്പ് നിങ്ങളെ സഹായിക്കുന്നു.'''),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: AwraadURL,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child:  Text(
                            'Awraad (Adkaar App)',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/awraad.png',
                              height: 80,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Expanded(
                              child: Text(
                                  '''പ്രാർത്ഥന പുസ്തകങ്ങളിൽ ഏറ്റവും മുന്നിൽ നിൽക്കുന്ന (സഹീഹുൽ അധ്കാർ) എന്ന കൃതിയുടെ മൊബൈൽ പതിപ്പാണ് ഈ അപ്ലിക്കേഷൻ.'''),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void AvoiceURL() async {
  if (!await launch(Avoiceurl)) throw 'Could not launch $Avoiceurl';
}

 void AwraadURL() async {
  if (!await launch(Awraadurl)) throw 'Could not launch $Awraadurl';
}

}
