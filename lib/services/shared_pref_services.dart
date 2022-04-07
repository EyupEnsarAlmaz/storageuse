import 'package:shared_preferences/shared_preferences.dart';
import 'package:storageuse/model/model.dart';

class SharedPreferenceService {
  void verilerikaydet(UserInformation userInformation) async {
    final _name = userInformation.name;
    final preferences = await SharedPreferences.getInstance();
    preferences.setString("name", _name);
    preferences.setBool("student", userInformation.ogrenciMi);
    preferences.setInt("gender", userInformation.gender.index);
    preferences.setStringList("colors", userInformation.colors);
  }

  Future<UserInformation> verilerioku() async {
    final preferences = await SharedPreferences.getInstance();
    var _names = preferences.getString("name") ?? "";
    var _student = preferences.getBool("student") ?? false;
    var _gender = Cinsiyet.values[preferences.getInt("gender") ?? 0];
    var _chosencolors = preferences.getStringList("colors") ?? <String>[];
    return UserInformation(_names, _gender, _chosencolors, _student);
  }
}
