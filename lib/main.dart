import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'helper/config.dart';
import 'helper/theme.dart';

import 'package:tasbih_digital/screen/menu/doa_harian.dart';
import 'package:tasbih_digital/screen/menu/doa_harian_detail.dart';
import 'package:tasbih_digital/screen/menu/doa_setelah_dzikir.dart';
import 'package:tasbih_digital/screen/menu/dzikir_setelah_sholat.dart';
import 'package:tasbih_digital/screen/home.dart';
import 'package:tasbih_digital/screen/menu/info.dart';
import 'package:tasbih_digital/screen/menu/list_dzikir.dart';
import 'package:tasbih_digital/screen/menu/setting.dart';
import 'package:tasbih_digital/screen/splash.dart';


void main() {
  runApp(
    new Home(),
  );
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tasbeeh Digital',
          home: Splash(),
          theme: notifier.darkMode ? dark_mode : light_mode,
          // theme: ThemeData(
          //   primaryColor: primaryColor,
          //   brightness: Brightness.light,
          // ),
          // // theme: Setting.isDark==true ? HomePage.dark : HomePage.light,
          // darkTheme: ThemeData(
          //   brightness: Brightness.dark,
          //   primaryColor: primaryColor,
          // ),

          // darkTheme: ThemeData.dark(),
          // themeMode: currentTheme.currentTheme(),
          routes: {
            HomePage.routeName: (context) => HomePage(),
            // ListDzikir.routeName: (context) => ListDzikir(),
            Info.routeName: (context) => Info(),
            Setting.routeName: (context) => Setting(),
            ListDzikir.routeName: (context) => ListDzikir(),
            DoaHarianScreen.routeName: (context) => DoaHarianScreen(),
            DetailDoaHarian.routeName: (context) => DetailDoaHarian(),
            DzikirBadaSholat.routeName: (context) => DzikirBadaSholat(),
            DoaAfterDzikir.routeName: (context) => DoaAfterDzikir(),
          },
        );
      }),
    );
  }
}
