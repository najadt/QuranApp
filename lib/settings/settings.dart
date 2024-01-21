import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/settings/settings_controller.dart';
import '../constants_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
        ),
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
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ ﰀ",
                  style:
                      TextStyle(fontFamily: 'quran', fontSize: arabicFontSize),
                  textDirection: TextDirection.rtl,
                ),
                Slider(
                    activeColor: Colors.green,
                    inactiveColor: Colors.green.shade200,
                    value: arabicFontSize,
                    min: 20,
                    max: 40,
                    onChanged: (value) {
                      setState(() {
                        arabicFontSize = value;
                      });
                    }),
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
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'പരമകാരുണികനും കരുണാനിധിയുമായ അല്ലാഹുവിന്റെ നാമത്തില്‍',
                  style: TextStyle(
                      fontFamily: 'malayalam', fontSize: malayalamFontSize),
                  //textDirection: TextDirection.rtl,
                ),
                Slider(
                    activeColor: Colors.green,
                    inactiveColor: Colors.green.shade200,
                    value: malayalamFontSize,
                    min: 10,
                    max: 25,
                    onChanged: (value) {
                      setState(() {
                        malayalamFontSize = value;
                      });
                    }),
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
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ ﰀ",
                  style:
                      TextStyle(fontFamily: 'quran', fontSize: mushafFontSize),
                  textDirection: TextDirection.rtl,
                ),
                Slider(
                    activeColor: Colors.green,
                    inactiveColor: Colors.green.shade200,
                    value: mushafFontSize,
                    min: 20,
                    max: 50,
                    onChanged: (value) {
                      setState(() {
                        mushafFontSize = value;
                      });
                    }),

                // const Padding(
                //   padding: EdgeInsets.only(top: 10, bottom: 10),
                //   child: Divider(),
                // ),
                // Obx(
                //   () => AnimatedToggleSwitch<bool>.dual(
                //     indicatorSize: const Size(40, 40),
                //     height: 40,
                //     current: controller.themeMode.value,
                //     onChanged: (i) {
                //       controller.themeMode.value = i;
                //       controller.changeTheme(i);
                //     },
                //     iconBuilder: (value) => value
                //         ? const Icon(Icons.nightlight,
                //             color: Colors.yellow, size: 32.0)
                //         : const Icon(Icons.light_mode,
                //             color: Colors.yellow, size: 32.0),
                //     style: ToggleStyle(
                //         backgroundColor: Theme.of(context).colorScheme.primary,
                //         borderColor: Colors.green,
                //         indicatorColor: Colors.green),
                //     first: true,
                //     second: false,
                //   ),
                // ),

                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(color: Colors.green))),
                        ),
                        onPressed: () {
                          setState(() {
                            arabicFontSize = 28;
                            mushafFontSize = 40;
                            malayalamFontSize = 15;
                            numberSystem = false;
                          });

                          saveSettings();
                          //Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.restore,
                          color: Colors.green,
                        ),
                        label: Text(
                          'Reset',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.green),
                        )),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(color: Colors.green))),
                        ),
                        onPressed: () {
                          saveSettings();
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.save,
                          color: Colors.green,
                        ),
                        label: Text(
                          'Save',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.green),
                        )),
                  ],
                ),

                //const Text('*Some settings will take effect after restart'),
              ],
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
    await prefs.setBool('theme', controller.themeMode.value);
  }
}
