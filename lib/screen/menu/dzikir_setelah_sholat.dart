import 'package:flutter/material.dart';
import 'package:tasbih_digital/dummy_data/dzikir_bada_sholat.dart';

class DzikirBadaSholat extends StatelessWidget {
  static const routeName = '/dzikir-badasholat';
  final dzikirsholat = DZIKIR_SHOLAT;
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
          return Container(
            margin: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Row(
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
                Text(
                  '${dzikirsholat[i]['arti']}',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Divider(),
              ],
            ),
          );
        },
        itemCount: DZIKIR_SHOLAT.length,
      ),
    );
  }
}
