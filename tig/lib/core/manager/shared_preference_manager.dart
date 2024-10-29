import 'package:shared_preferences/shared_preferences.dart';

enum PrefsType {
  isLoggedIn,
  userId,
  isOnDaily,
  isOnBraindump,
  tags,
}

extension on PrefsType {
  String get prefsName {
    return toString();
  }
}

class SharedPreferenceManager {
  SharedPreferenceManager._privateConstructor();

  static final SharedPreferenceManager _instance =
      SharedPreferenceManager._privateConstructor();

  factory SharedPreferenceManager() => _instance;

  late final SharedPreferences _prefs;

  SharedPreferences get prefs => _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  T? getPref<T>(PrefsType type) {
    switch (type) {
      case PrefsType.tags:
        return _prefs.getStringList(type.prefsName) as T?;
      case PrefsType.userId:
        return _prefs.getString(type.prefsName) as T?;
      default:
        return _prefs.getBool(type.prefsName) as T?;
    }
  }

  setPref<T>(PrefsType type, T pref) async {
    switch (type) {
      case PrefsType.userId:
        await _prefs.setString(type.prefsName, pref as String);
        break;
      case PrefsType.tags:
        await _prefs.setStringList(type.prefsName, pref as List<String>);
        break;
      default:
        await _prefs.setBool(type.prefsName, pref as bool);
        break;
    }
  }

  removePref(PrefsType type) async {
    await _prefs.remove(type.prefsName);
  }
}
