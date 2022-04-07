import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/model.dart';

class SecureStorageService {
  late final FlutterSecureStorage preferences;
  void verilerikaydet(UserInformation userInformation) async {
    final _name = userInformation.name;
    await preferences.write(key: "name", value: _name);
    await preferences.write(
        key: "student", value: userInformation.ogrenciMi.toString());
    await preferences.write(
        key: "gender", value: userInformation.gender.index.toString());
    await preferences.write(
        key: "colors", value: jsonEncode(userInformation.colors));
  }

  Future<UserInformation> verilerioku() async {
    preferences = FlutterSecureStorage();
    var _names = await preferences.read(key: "name") ?? "";
    var _studentString = await preferences.read(key: "student") ?? "false";
    var _student = _studentString.toLowerCase() == "true" ? true : false;
    var _genderString = await preferences.read(key: "gender") ?? "0";
    var _gender = Cinsiyet.values[int.parse(_genderString)];
    var _chosencolorsString = await preferences.read(key: "colors");
    var _chosencolors = _chosencolorsString == null
        ? <String>[]
        : List<String>.from(jsonDecode(_chosencolorsString));
    return UserInformation(_names, _gender, _chosencolors, _student);
  }
}
