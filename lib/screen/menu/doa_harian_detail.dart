import 'package:flutter/material.dart';
import 'package:tasbih_digital/dummy_data/doa_harian.dart';

class DetailDoaHarian extends StatelessWidget {
  static const routeName = '/detail-doaharian';

  @override
  Widget build(BuildContext context) {
    /**
     * ambil id doa harian yang dipilih melalui modalroute
     * kemudian buat variabel untuk simpan doa yang dipilih
     */
    final int id = ModalRoute.of(context)!.settings.arguments as int;
    final Map<String, dynamic> selectedDoa = DOA_HARIAN[id];
    
    /**
     * Pecah ke masing-masing data
     */
    final String arti = selectedDoa['arti'];
    final String latin = selectedDoa['latin'];
    final String doa = selectedDoa['arab'];
    
    /**
     * Pisah kata jika menemui titik
     * kemudia masukkan ke list
     */
    List<String> artiDoa = arti.split(".");
    List<String> latinDoa = latin.split(".");
    List<String> arabDoa = doa.split(".");
    
    //Widget rendered to screen
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedDoa['judul']),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          left: 16,
          top: 16,
          bottom: 16,
        ),
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 40,
              right: 5,
              bottom: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: arabDoa
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "$e.",
                        style: TextStyle(
                          fontSize: 32.0,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: latinDoa
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "$e.",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(
            height: 25.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: artiDoa
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "$e.",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            selectedDoa['footnote'],
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
