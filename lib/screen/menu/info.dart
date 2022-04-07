import 'package:flutter/material.dart';
import 'package:tasbih_digital/helper/config.dart';

class Info extends StatelessWidget {
  static const routeName = '/info';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info Aplikasi'),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: MediaQuery.of(context).platformBrightness ==
                          Brightness.light
                      ? Colors.blue
                      : secondaryColor,
                ),
                child: Icon(
                  Icons.mosque,
                  size: 60.0,
                  color: Colors.white,
                ),
              ),
              Text(
                'Tasbih Digital',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Teman Dzikir Harian Anda',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text('Hak Cipta @2022'),
              Column(
                children: [
                  Text(
                    'MADTECH.CORP',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 125,
                    height: 5,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
