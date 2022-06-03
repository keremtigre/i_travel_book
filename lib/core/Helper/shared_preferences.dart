import 'package:shared_preferences/shared_preferences.dart';

Future<void> putBool(String key, bool deger) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool(key, deger);
}

Future<bool> getBool(String key) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getBool(key) ?? false;
}

Future<void> putString(String key, String deger) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString(key, deger);
}

Future<String> getString(String key) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString(key) ?? "";
}

Future<void> removeData() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.remove("hatirla");
  await preferences.remove("email");
  await preferences.remove("password");
}

//*********************************************************************************/
//Dark -Light Mode için
void saveData(String key, dynamic value) async {
  final prefs = await SharedPreferences.getInstance();
  if (value is int) {
    prefs.setInt(key, value);
  } else if (value is String) {
    prefs.setString(key, value);
  } else if (value is bool) {
    prefs.setBool(key, value);
  } else {
    print("Invalid Type");
  }
}

Future<dynamic> readData(String key) async {
  final prefs = await SharedPreferences.getInstance();
  dynamic obj = prefs.get(key);
  return obj;
}

Future<bool> deleteData(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.remove(key);
}
