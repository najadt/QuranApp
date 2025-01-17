import 'package:quran/constants_variables.dart';
import 'package:flutter/material.dart';
import 'package:quran/support_dev.dart';
import 'about.dart';
import 'other_apps.dart';
import 'package:share_plus/share_plus.dart';
import 'settings/settings.dart';
import 'package:url_launcher/url_launcher.dart';

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
          DrawerHeader(
            decoration: const BoxDecoration(
                //color: Colors.white,
                ),
            child: Column(
              children: [
                Image.asset(
                  'assets/quran.png',
                  height: 80,
                ),
                const Text(
                  'Al Quran',
                  style: TextStyle(fontSize: 20),
                ),
                const Text('മലയാളം അർത്ഥസഹിതം')
              ],
            ),
          ),
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
          ListTile(
            leading: const Icon(
              Icons.shopping_cart,
            ),
            title: const Text(
              'Islamic Shop',
            ),
            onTap: () async {
              if (!await launchUrl(sunnahSouq,
                  mode: LaunchMode.externalApplication)) {
                throw 'Could not launch $sunnahSouq';
              }
            },
          ),
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
              if (!await launchUrl(quranAppurl,
                  mode: LaunchMode.externalApplication)) {
                throw 'Could not launch $quranAppurl';
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.monetization_on),
            title: const Text('Support Developer'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DonationPage(),
                  ));
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
          ListTile(
            leading: const Icon(
              Icons.chat,
            ),
            title: const Text(
              'Report Error',
            ),
            onTap: () async {
              if (!await launchUrl(whatsAppUrl,
                  mode: LaunchMode.externalApplication)) {
                throw 'Could not launch $whatsAppUrl';
              }
            },
          ),
        ],
      ),
    );
  }
}
