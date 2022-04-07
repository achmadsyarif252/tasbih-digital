import 'package:flutter/material.dart';
import '../../dummy_data/doa_dzikir.dart';

class DoaAfterDzikir extends StatelessWidget {
  static const routeName = '/doa-dzikir';
  final dzikirsholat = DOA_DZIKIR;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dzikir Setelah Sholat',
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) {
          final String doa = DOA_DZIKIR[i]['arti'] as String;
          List<String> artiDoa = doa.split(".");
          return Container(
            margin: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Text(
                          '${i + 1}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '${dzikirsholat[i]['arab']}',
                          style: TextStyle(fontSize: 32),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  '${dzikirsholat[i]['latin']}',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: artiDoa
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              e,
                              style: TextStyle(fontSize: 20.0),
                              textAlign: TextAlign.start,
                            ),
                          ))
                      .toList(),
                ),
                Divider(),
              ],
            ),
          );
        },
        itemCount: DOA_DZIKIR.length,
      ),
    );
  }
}
