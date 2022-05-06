import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_client_app/models/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red
];

class Global {
  static late SharedPreferences _pref;
  static Profile profile = Profile();
  static List<MaterialColor> get themes => _themes;
  static bool get isRealease => bool.fromEnvironment("dart.vm.producte");

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _pref = await SharedPreferences.getInstance();
    var _profile = _pref.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    } else {
      profile = Profile()..theme = 0;
    }

    profile.cache = profile.cache ?? CacheConfig();
    // ..enable = true;
    // ..maxAge = 3600;
    // ..maxCount = 100;
  }

  static saveProfile() =>
      _pref.setString("profile", jsonEncode(profile.toJson()));
}
