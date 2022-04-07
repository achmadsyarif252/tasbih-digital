import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tasbih_digital/screen/home.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  /**
   * Beri jeda waktu n detik pada saat aplikasi di buka
   * sebelum menuju halama homepage
   */
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              width: 200,
              height: 200,
              child: FloatingActionButton(
                onPressed: () {},
                child: Icon(
                  Icons.mosque_rounded,
                  size: 150,
                ),
              ),
            ),
            Spacer(),
            Text(
              'FROM',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Text(
              'MADTECH.CORP',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
