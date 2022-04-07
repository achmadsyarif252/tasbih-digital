import 'package:flutter/material.dart';
import 'package:tasbih_digital/model/dzikir.dart';
import '../helper/config.dart';
import '../helper/mytheme.dart';

import 'package:tasbih_digital/screen/menu/doa_harian.dart';
import 'package:tasbih_digital/screen/menu/doa_setelah_dzikir.dart';
import 'package:tasbih_digital/screen/menu/dzikir_setelah_sholat.dart';
import 'package:tasbih_digital/screen/menu/info.dart';
import 'package:tasbih_digital/screen/menu/list_dzikir.dart';
import 'package:tasbih_digital/screen/menu/setting.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'menu/dzikir_setelah_sholat.dart';
import 'menu/info.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AudioCache _audioCache;
  TextEditingController batasController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  //color untuk warna floatingAction Button
  Color pickerColor = MyTheme.isDark ? primaryColor : Colors.blue;
  Color currentColor = Colors.blue;

  // ValueChanged<Color> callback (part of library pickercolor)
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  var savedData = [];
  Map<String, dynamic> savedCounter = {};

//method untuk menangani user klik tekan tombol dzikir
  addCounter() async {
    Map<String, dynamic> savedCounter = await Data.getCounter();
    int index = savedCounter['selectedDzikir'];
    savedCounter = {
      'counter': savedCounter['counter'] == savedCounter['batas']!
          ? 1
          : savedCounter['counter'] + 1,
      'batas': savedCounter['batas'],
      'selectedDzikir': index,
      'profile': savedCounter['profile'],
      'buttonColor': savedCounter['buttonColor'],
    };

    Map<String, dynamic> selectedDzikir = savedData[index];

    selectedDzikir = {
      'name': selectedDzikir['name'],
      'total': selectedDzikir['total'] + 1
    };

    savedData[index] = selectedDzikir;

    await Data.savedCounter(savedCounter);
    await Data.savedTasbeh(savedData);
    getSavedData();
  }

//method untuk mengubah profil getar/hening/nada aplikasi
  saveProfile(int profile) async {
    Map<String, dynamic> savedCounter = await Data.getCounter();
    int index = savedCounter['selectedDzikir'];
    savedCounter = {
      'counter': savedCounter['counter'],
      'batas': savedCounter['batas'],
      'selectedDzikir': savedCounter['selectedDzikir'],
      'profile': profile,
      'buttonColor': savedCounter['buttonColor'],
    };

    await Data.savedCounter(savedCounter);
    getSavedData();
  }

  //method untuk simpan warna floatingActionButton
  saveColor(Color color) async {
    Map<String, dynamic> savedCounter = await Data.getCounter();
    int index = savedCounter['selectedDzikir'];
    savedCounter = {
      'counter': savedCounter['counter'],
      'batas': savedCounter['batas'],
      'selectedDzikir': savedCounter['selectedDzikir'],
      'profile': savedCounter['profile'],
      'buttonColor': color.value,
    };

    await Data.savedCounter(savedCounter);
    getSavedData();
  }

//method untuk simpan ke sharedpreferences bacacn yang dipilih
  saveSelectedDzikir(int selected) async {
    Map<String, dynamic> savedCounter = await Data.getCounter();
    savedCounter = {
      'counter': 0,
      'batas': savedCounter['batas'],
      'selectedDzikir': selected,
      'profile': savedCounter['profile'],
      'buttonColor': savedCounter['buttonColor'],
    };

    await Data.savedCounter(savedCounter);
    getSavedData();
  }

  //reset semua data tasbih ke 0
  reset() async {
    Map<String, dynamic> savedCounter = {
      'counter': 0,
      'batas': 33,
      'selectedDzikir': 0,
      'profile': 0,
      'buttonColor': pickerColor.value,
    };

    var newTasbehData = [];
    for (int i = 0; i < savedData.length; i++) {
      var newsavedData = {
        'name': savedData[i]['name'],
        'total': 0,
      };
      newTasbehData.add(newsavedData);
    }

    savedData.clear();
    await Data.savedTasbeh(newTasbehData);
    await Data.savedCounter(savedCounter);
    getSavedData();
  }

  //simpan data pertama kali aplikasi diinstal (initial data aplikasi ini)
  saveData() async {
    List<Map<String, dynamic>> tasbeh = [
      {
        'name': 'Subhanallah',
        'total': 0,
      },
      {
        'name': 'Alhamdulillah',
        'total': 0,
      },
      {
        'name': 'AllahuAkbar',
        'total': 0,
      },
    ];
    // var customer = {'name': "Subhanallah", 'adress': 0};
    Map<String, dynamic> counter = {
      'counter': 0,
      'batas': 33,
      'selectedDzikir': 1,
      'profile': 0,
      'buttonColor': pickerColor.value,
    };
    int indexDzikir = 1;

    // ambil data Shared Preferences sebagai list
    var savedTasbeh = await Data.getTasbeh();
    var savedCounter = await Data.getCounter();
    // savedData.add(counter);
    savedCounter = counter;
    tasbeh.map((e) {
      savedTasbeh.add(e);
    }).toList();

    await Data.savedTasbeh(savedTasbeh);
    await Data.savedCounter(savedCounter);
  }

  // method untuk mengambil data Shared Preferences
  getSavedData() async {
    var data = await Data.getTasbeh();
    var counter = await Data.getCounter();
    // setelah data didapat panggil setState agar data segera dirender

    if (data.length == 0) {
      await saveData();
    }
    data = await Data.getTasbeh();
    counter = await Data.getCounter();
    // indexDzikir = await savedCounter['selectedDzikir'];
    setState(() {
      savedData = data;
      savedCounter = counter;
    });
    // batasController.text = '${savedCounter['batas']}';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _audioCache = AudioCache(
      prefix: 'audio/',
      fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
    );
    getSavedData();
  }

//untuk setel efek suara saat tasbih diklik
  final player = AudioCache();
  List<IconData> icon = [
    Icons.volume_up,
    Icons.vibration,
    Icons.volume_mute_sharp,
  ];

  @override
  Widget build(BuildContext context) {
//method untuk menyimpan batasan tasbih 1 putaran
    saveBatas(int batas) async {
      final isValid = key.currentState!.validate();
      if (isValid) {
        Map<String, dynamic> savedCounter = await Data.getCounter();
        savedCounter = {
          'counter': savedCounter['counter'],
          'batas': batas,
          'selectedDzikir': savedCounter['selectedDzikir'],
          'profile': savedCounter['profile'],
          'buttonColor': savedCounter['buttonColor'],
        };

        await Data.savedCounter(savedCounter);
        saveSelectedDzikir(savedCounter['selectedDzikir']);
        getSavedData();
        Navigator.of(context).pop();
      }
    }

    //method simpan bacan dzikir yang akan dilakukan
    saveDzikir(int selected) {
      setState(() {
        saveSelectedDzikir(selected);
      });
      Navigator.of(context).pop();
    }

    //tampilkan modal untuk batasan dzikir /putaran
    batasDialog() {
      return showDialog(
          context: context,
          builder: (ctx) {
            return Form(
              key: key,
              child: AlertDialog(
                scrollable: true,
                title: Text('Ganti Batas Hitung'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Masukkan batas hitung akhir',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    TextFormField(
                      validator: (e) {
                        if (e!.isEmpty) {
                          return "Isi Batas Akhir";
                        }
                        return null;
                      },
                      controller: batasController,
                      keyboardType: TextInputType.number,
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
                        saveBatas(int.parse(batasController.text));
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
    }

    int savedSelected = savedCounter['selectedDzikir'];

    //menampilkan bacaan dzikir yang ada
    dzikirDialog() {
      return showDialog(
          context: context,
          builder: (ctx) {
            return StatefulBuilder(
              builder: (ctx, setState) {
                return AlertDialog(
                  scrollable: true,
                  title: Text('Pilih Bacaan Dzikir'),
                  content: Container(
                    height: 500,
                    width: 300,
                    child: Form(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (ctx, i) {
                          return ListTile(
                            title: Text('${savedData[i]['name']}'),
                            trailing: Radio(
                                value: i,
                                groupValue: savedSelected,
                                onChanged: (val) {
                                  setState(() {
                                    // dzikir.selectedDzikir = val as int;
                                    savedSelected = val as int;
                                  });
                                }),
                          );
                        },
                        itemCount: savedData.length,
                      ),
                    ),
                  ),
                  actions: [
                    Container(
                      margin: const EdgeInsets.all(12.0),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed(
                                ListDzikir.routeName,
                              );
                            },
                            icon: Icon(Icons.list_alt),
                            label: Text(
                              'TAMBAH BACAAN DZIKIR',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
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
                              Spacer(),
                              Container(
                                height: 40,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  onPressed: () {
                                    saveDzikir(savedSelected);
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
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          });
    }

//Widget rendered to screen
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Tasbih Digital'),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (savedCounter['profile']! < 2) {
                      savedCounter['profile'] = savedCounter['profile']! + 1;
                    } else {
                      savedCounter['profile'] = 0;
                    }
                  });
                  saveProfile(savedCounter['profile']);
                },
                icon: Icon(
                  icon[savedCounter['profile']],
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text(
                          'Reset Total Hitung',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        content: Container(
                          height: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Total hitung dzikir akan di setel ulang menjadi nol'),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Apakah Anda yakin',
                              ),
                              Spacer(),
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      height: 40,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.white,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'TIDAK',
                                          style: TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          setState(() {
                                            reset();
                                          });
                                        },
                                        child: Text(
                                          'YA',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.restore,
                ),
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (ctx) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.linear_scale_outlined,
                              size: 28.0,
                              color: Colors.grey.shade700,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.info,
                                        size: 40.0,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed(Info.routeName);
                                      },
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Info\nAplikasi',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.menu_book,
                                        size: 40.0,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            DzikirBadaSholat.routeName);
                                      },
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Dzikir\nSetelah\nSholat',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.menu_book_rounded,
                                        size: 40.0,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            DoaAfterDzikir.routeName);
                                      },
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Doa\nSetelah\nDzikir',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.book_online,
                                        size: 40.0,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed(ListDzikir.routeName);
                                      },
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Bacaan\nDzikir',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 30.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.mosque,
                                          size: 40.0,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              DoaHarianScreen.routeName);
                                        },
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Doa\nHarian',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.color_lens,
                                          size: 40.0,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) {
                                              return AlertDialog(
                                                title:
                                                    const Text('Pick a color!'),
                                                content: SingleChildScrollView(
                                                  child: ColorPicker(
                                                    pickerColor: pickerColor,
                                                    onColorChanged: changeColor,
                                                  ),
                                                  // Use Material color picker:
                                                  //
                                                  // child: MaterialPicker(
                                                  //   pickerColor: pickerColor,
                                                  //   onColorChanged: changeColor,
                                                  //   showLabel: true, // only on portrait mode
                                                  // ),
                                                  //
                                                  // Use Block color picker:
                                                  //
                                                  // child: BlockPicker(
                                                  //   pickerColor: currentColor,
                                                  //   onColorChanged: changeColor,
                                                  // ),
                                                  //
                                                  // child: MultipleChoiceBlockPicker(
                                                  //   pickerColors: currentColors,
                                                  //   onColorsChanged: changeColors,
                                                  // ),
                                                ),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    child: const Text('Simpan'),
                                                    onPressed: () {
                                                      saveColor(pickerColor);
                                                      setState(() =>
                                                          currentColor =
                                                              pickerColor);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Tema\nAplikasi',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.ads_click,
                                        size: 40.0,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Hapus\nIklan',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.settings,
                                          size: 40.0,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed(Setting.routeName);
                                        },
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Pengaturan',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.menu,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder(
          future: getSavedData(),
          builder: (context, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          batasDialog();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${savedCounter['counter']}',
                              style: TextStyle(
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '/',
                              style: TextStyle(
                                fontSize: 30.0,
                              ),
                            ),
                            Text(
                              '${savedCounter['batas']}',
                              style: TextStyle(fontSize: 24.0),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Total : ${savedData[savedCounter['selectedDzikir']]['total']}',
                        // 'Total',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          dzikirDialog();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${savedData[savedCounter['selectedDzikir']]['name']}', //selectedDzikir
                              style: TextStyle(fontSize: 22.0),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  width: 350,
                  height: 350,
                  child: FloatingActionButton(
                    backgroundColor: new Color(savedCounter['buttonColor']),
                    onPressed: () {
                      if (savedCounter['profile'] == 0) {
                        player.play('audio/tic.mp3');
                        if (savedCounter['counter'] ==
                            savedCounter['batas']! - 1) {
                          Vibration.vibrate(duration: 200);
                        }
                      } else if (savedCounter['profile'] == 1) {
                        Vibration.vibrate(duration: 80);
                      }
                      setState(() {
                        addCounter();
                      });
                    },
                    child: Icon(
                      Icons.mosque_outlined,
                      size: 180,
                    ),
                  ),
                ),
                Spacer(),
              ],
            );
          }),
    );
  }
}
