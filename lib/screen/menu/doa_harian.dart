import 'package:flutter/material.dart';
import 'package:tasbih_digital/dummy_data/doa_harian.dart';
import 'doa_harian_detail.dart';

class DoaHarianScreen extends StatelessWidget {
  static const routeName = '/doa-harian';

  //halaman doa harian,menampilkan daftar nama doa harian yang ada di aplikasi
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doa Harian'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) {
          return ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(DetailDoaHarian.routeName, arguments: i);
            },
            leading: Text('${i+1}.'),
            title: Text('${DOA_HARIAN[i]['judul']}'),
          );
        },
        itemCount: DOA_HARIAN.length,
      ),
    );
  }
}
