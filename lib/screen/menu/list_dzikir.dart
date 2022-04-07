import 'package:flutter/material.dart';
import '../../model/dzikir.dart';

class ListDzikir extends StatefulWidget {
  static const routeName = '/list-dzikir';

  @override
  State<ListDzikir> createState() => _ListDzikirState();
}

class _ListDzikirState extends State<ListDzikir> {
  GlobalKey<FormState> key2 = GlobalKey<FormState>();

  TextEditingController namaController = TextEditingController();

  /**
   * method untuk save/edit dzikir
   * status menujukaan fungsi (0=simpan,1=edit)
   * index menunjukkan index yang akan diedit datanya
   */
  saveDzikir(int status, int index) async {
    Map<String, dynamic> tasbeh = {
      'name': namaController.text,
      'total': 0,
    };

    // ambil data Shared Preferences sebagai list
    var savedTasbeh = await Data.getTasbeh();
    var savedCounter = await Data.getCounter();

    //jika user tambah bacaan dzikir
    if (status == 0) {
      savedTasbeh.add(tasbeh);
    } else if (status == 1) {
      //jika user edit bacaan dzikir
      savedTasbeh[index] = tasbeh;
    }

    //masukkan ke shared preferences agar data presisten
    await Data.savedTasbeh(savedTasbeh);
    await Data.savedCounter(savedCounter);

    //ambil kembali data terbaru
    getSavedData();
    Navigator.of(context).pop();
  }

  var savedData = [];

// method untuk mengambil data Shared Preferences
  getSavedData() async {
    var data = await Data.getTasbeh();
    data = await Data.getTasbeh();
    setState(() {
      savedData = data;
    });
  }

  //delete dzikir
  delete(int index) async {
    // ambil data Shared Preferences sebagai list
    var savedTasbeh = await Data.getTasbeh();
    savedTasbeh.removeAt(index);
    await Data.savedTasbeh(savedTasbeh);
    getSavedData();
  }

  @override
  Widget build(BuildContext context) {
    //show modal untuk tampilkan edit bacaan
    dialogEdit(int index) {
      namaController.text = savedData[index]['name'];
      return showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('Edit Bacaan'),
              content: TextField(
                controller: namaController,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Batal'),
                ),
                TextButton(
                  onPressed: () {
                    saveDzikir(1, index);
                  },
                  child: Text('Simpan'),
                ),
              ],
            );
          });
    }

//method untuk menangani pilihan user saat klik opsi pada list bacaan
    void actionPopUpItemSelected(int index, String value) {
      String? message;
      if (value == 'edit') {
        dialogEdit(index);
      } else if (value == 'delete') {
        delete(index);
        message = "Berhasil dihapus";
      }
      final snackBar = SnackBar(content: Text(message!));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    //Widget dispalyed to user
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Bacaan Dzikir'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (ctx) {
                return Form(
                  key: key2,
                  child: AlertDialog(
                    scrollable: true,
                    title: Text('Tambahakn Bacaan Dzikir'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Masukkan bacaan dzikir yang ingin ditambahkan',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        TextFormField(
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Isi bacaan dzikir";
                            }
                            return null;
                          },
                          controller: namaController,
                        ),
                      ],
                    ),
                    actions: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(5.0)),
                        height: 40,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'BATAL',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 40,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            saveDzikir(0, -1);
                          },
                          child: Text(
                            'SIMPAN',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: getSavedData(),
          builder: (ctx, _) {
            return ListView.builder(
              itemBuilder: (ctx, i) {
                return ListTile(
                  title: Text('${savedData[i]['name']}'),
                  trailing: PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text('Hapus'),
                        )
                      ];
                    },
                    onSelected: (String value) =>
                        actionPopUpItemSelected(i, value),
                  ),
                );
              },
              itemCount: savedData.length,
            );
          }),
    );
  }
}
