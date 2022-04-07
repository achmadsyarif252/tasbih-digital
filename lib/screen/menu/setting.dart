import 'package:flutter/material.dart';
import 'package:tasbih_digital/helper/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import '../../helper/config.dart';

class Setting extends StatelessWidget {
  static const routeName = '/setting';
  bool isDark = true;
  final String _url = 'https://flutter.dev';

  void _launchURL() async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final light = MediaQuery.of(context).platformBrightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
        children: [
          ListTile(
            title: Text('Tasbih Digital'),
            subtitle: Text('Versi Gratis'),
            leading: Consumer<ThemeNotifier>(
              builder: (context, notifier, child) => Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: notifier.darkMode ? secondaryColor : Colors.blue,
                ),
                child: Icon(
                  Icons.mosque,
                  color: Colors.white,
                  size: 40.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Tema',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          ListTile(
            leading: Icon(
              Icons.light_mode,
            ),
            title: Text(
              'Mode Gelap',
              style: TextStyle(fontSize: 14.0),
            ),
            trailing: Consumer<ThemeNotifier>(
              builder: (context, notifier, child) => Switch(
                value: notifier.darkMode,
                onChanged: (val) {
                  notifier.toggleChangeTheme();
                },
              ),
            ),
          ),
          Divider(),
          SizedBox(
            height: 15.0,
          ),
          buildListTile(Icons.book_sharp, "Kebijakan privasi", () {}),
          buildListTile(Icons.menu_book, "Ketentuan penggunaan", () {}),
          buildListTile(Icons.share, "Bagikan aplikasi ini", () {}),
          Divider(),
          SizedBox(
            height: 15.0,
          ),
          Text(
            'Ikuti Kami',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          buildListTile(Icons.web, "Website", _launchURL),
          buildListTile(Icons.youtube_searched_for, "Youtube", () {}),
          buildListTile(Icons.facebook, "Facebook", () {}),
          buildListTile(Icons.camera, "Instagram", () {}),
          buildListTile(Icons.newspaper_sharp, "Twitter", () {}),
          Divider(),
          SizedBox(
            height: 35.0,
          ),
          Center(
            child: Text(
              'MADTECH.CORP',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /**
   * Widget untuk listtile menu
   */
  ListTile buildListTile(IconData icon, String teks, Function onPress) {
    return ListTile(
      onTap: () => onPress,
      leading: Icon(
        icon,
      ),
      title: Text(
        teks,
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
