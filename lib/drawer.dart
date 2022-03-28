import 'package:Quran/constants_variables.dart';
import 'package:flutter/material.dart';
import 'about.dart';
import 'constants_variables.dart';
import 'other_apps.dart';
import 'package:share_plus/share_plus.dart';
import 'settings.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:url_launcher/url_launcher.dart';
//import 'about.dart';
//import 'share_content.dart';
//mport 'constants_variables.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: const Color.fromARGB(255, 253, 251, 240) ,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // const DrawerHeader(
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //   ),
          //   child: null
          // ),

          ListTile(
            leading: const Icon(
              Icons.settings,
            ),
            title: const Text(
              'Settings',
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Settings()));
            },
          ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.bookmark,
          //   ),
          //   title: const Text(
          //     'Bookmarks',
          //   ),
          //   onTap: () {},
          // ),
          ListTile(
            leading: const Icon(
              Icons.apps,
            ),
            title: const Text(
              'Other Apps',
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const OtherApps()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.share,
            ),
            title: const Text(
              'Share',
            ),
            onTap: () {
              Share.share('''*Quran with malayalam meaning*\n
Download from https://play.google.com/store/apps/details?id=org.ahlussunnabooks.quran''');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.rate_review,
            ),
            title: const Text(
              'Rate',
            ),
            onTap: () async {
              if (!await launch(quranAppurl)) throw 'Could not launch $quranAppurl';
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
            ),
            title: const Text(
              'About',
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}

// void launchURL() async {
//   if (!await launch(url)) throw 'Could not launch $url';
// }

// void openStoreListing() async {
//   if (!await launch(storeUrl)) throw 'Could not launch $storeUrl';
// }

