import 'package:flutter/material.dart';
import 'constants_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Material(
      //theme: ThemeData(primarySwatch: Colors.green
      //),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Settings",
          ),
          backgroundColor: const Color.fromARGB(255, 56, 115, 59),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Arabic Font Size:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Slider(
                      value: arabicFontSize,
                      min: 20,
                      max: 40,
                      onChanged: (value) {
                        setState(() {
                          arabicFontSize = value;
                        });
                      }),
                  Text(
                    "‏ ‏‏ ‏‏‏‏ ‏‏‏‏‏‏ ‏",
                    style: TextStyle(
                        fontFamily: 'quran', fontSize: arabicFontSize),
                    textDirection: TextDirection.rtl,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Divider(),
                  ),
                  const Text(
                    'Malayalam Font Size:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Slider(
                      value: malayalamFontSize,
                      min: 10,
                      max: 25,
                      onChanged: (value) {
                        setState(() {
                          malayalamFontSize = value;
                        });
                      }),
                  Text(
                    'പരമകാരുണികനും കരുണാനിധിയുമായ അല്ലാഹുവിന്റെ നാമത്തില്‍',
                    style: TextStyle(
                        fontFamily: 'malayalam', fontSize: malayalamFontSize),
                    //textDirection: TextDirection.rtl,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Divider(),
                  ),
                  const Text(
                    'Mushaf Mode Font Size:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Slider(
                      value: mushafFontSize,
                      min: 20,
                      max: 50,
                      onChanged: (value) {
                        setState(() {
                          mushafFontSize = value;
                        });
                      }),
                  Text(
                    "‏ ‏‏ ‏‏‏‏ ‏‏‏‏‏‏ ‏",
                    style: TextStyle(
                        fontFamily: 'quran', fontSize: mushafFontSize),
                    textDirection: TextDirection.rtl,
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.only(top: 10, bottom: 10),
                  //   child: Divider(),
                  // ),
                  // const Text(
                  //   'Index Numbering System:',
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 15,
                  //   ),
                  // ),
                  // ListTile(
                  //   leading: Radio<bool>(
                  //     value: true,
                  //     groupValue: numberSystem,
                  //     onChanged: (value) {
                  //       setState(() {
                  //         numberSystem = value!;
                  //       });
                  //     },
                  //   ),
                  //   title: const Text('Arabic'),
                  // ),
                  // ListTile(
                  //   leading: Radio<bool>(
                  //     value: false,
                  //     groupValue: numberSystem,
                  //     onChanged: (value) {
                  //       setState(() {
                  //         numberSystem = value!;
                  //       });
                  //     },
                  //   ),
                  //   title: const Text('English'),
                  // ),
                
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              arabicFontSize = 28;
                              mushafFontSize = 40;
                              malayalamFontSize = 15;
                              numberSystem = true;
                            });

                            saveSettings();
                            //Navigator.pop(context);
                          },
                          child: const Text('Reset')),
                      ElevatedButton(
                          onPressed: () {
                            saveSettings();
                            Navigator.pop(context);
                          },
                          child: const Text('Save')),
                    ],
                  ),

                  //const Text('*Some settings will take effect after restart'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('arabicFontSize', arabicFontSize.toInt());
    await prefs.setInt('malayalamFontSize', malayalamFontSize.toInt());
    await prefs.setInt('mushafFontSize', mushafFontSize.toInt());
    await prefs.setBool('numberSystem', numberSystem);
  }
}
