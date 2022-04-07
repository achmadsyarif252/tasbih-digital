import 'package:shared_preferences/shared_preferences.dart'; // import module untuk baca dan tulis Shared Preferences
import 'dart:convert'; // import module untuk mengubah data Shared Preferences yang berupa string menjadi list atau map dart

class Data {
  // baca data dari smartphone
  static getTasbeh() async {
    var prefs = await SharedPreferences.getInstance();
    var savedData = prefs.getString('tasbeh');
    savedData ??= '[]';
    return json.decode(savedData);
  }

  static getCounter() async {
    var prefs = await SharedPreferences.getInstance();
    var savedData = prefs.getString('counter');
    savedData ??= '[]';
    return json.decode(savedData);
  }

  static savedTasbeh(data) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('tasbeh', json.encode(data));
  }

  static savedCounter(data) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('counter', json.encode(data));
  }
}
