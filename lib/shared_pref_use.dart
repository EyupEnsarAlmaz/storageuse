import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storageuse/model/model.dart';
import 'package:storageuse/services/secure_storage.dart';
import 'package:storageuse/services/shared_pref_services.dart';

class SharedPrefUse extends StatefulWidget {
  SharedPrefUse({Key? key}) : super(key: key);

  @override
  State<SharedPrefUse> createState() => _SharedPrefUseState();
}

class _SharedPrefUseState extends State<SharedPrefUse> {
  var _secilencinsiyet = Cinsiyet.FEMALE;
  var _secilenRenkler = <String>[];
  var _ogrenci = false;
  TextEditingController _namecontroller = TextEditingController();
  var _preferenceService = SecureStorageService();

  @override
  void initState() {
    super.initState();
    _verilerioku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Shared Pref Use")),
        body: ListView(
          children: [
            // ignore: prefer_const_constructors
            ListTile(
              title: TextField(
                  controller: _namecontroller,
                  decoration: InputDecoration(labelText: "Enter Your Name")),
            ),
            for (var item in Cinsiyet.values)
              _buildRadioListTiles(describeEnum(item), item),
            for (var item in Renkler.values) _buildCheckBoxListTiles(item),
            SwitchListTile(
                title: Text("Are You Student?"),
                value: _ogrenci,
                onChanged: (bool ogrenciMi) {
                  setState(() {
                    _ogrenci = ogrenciMi;
                  });
                }),
            TextButton(
                onPressed: () {
                  var _userinformation = UserInformation(_namecontroller.text,
                      _secilencinsiyet, _secilenRenkler, _ogrenci);
                  _preferenceService.verilerikaydet(_userinformation);
                },
                child: Text("Save"))
          ],
        ));
  }

  Widget _buildCheckBoxListTiles(Renkler renk) {
    return CheckboxListTile(
        title: Text(describeEnum(renk)),
        value: _secilenRenkler.contains(describeEnum(renk)),
        onChanged: (bool? deger) {
          if (deger == false) {
            _secilenRenkler.remove(describeEnum(renk));
          } else {
            _secilenRenkler.add(describeEnum(renk));
          }
          setState(() {});
        });
  }

  Widget _buildRadioListTiles(String title, Cinsiyet cinsiyet) {
    return RadioListTile(
        title: Text(title),
        value: cinsiyet,
        groupValue: _secilencinsiyet,
        onChanged: (Cinsiyet? secilmiscinsiyet) {
          setState(() {
            _secilencinsiyet = secilmiscinsiyet!;
          });
        });
  }

  void _verilerioku() async {
    var info = await _preferenceService.verilerioku();
    _namecontroller.text = info.name;
    _secilencinsiyet = info.gender;
    _secilenRenkler = info.colors;
    _ogrenci = info.ogrenciMi;
    setState(() {});
  }
}
