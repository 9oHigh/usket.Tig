import 'package:shared_preferences/shared_preferences.dart';
import 'package:tig/presentation/screens/option/provider/state/option_state.dart';

enum PrefsType {
  isLoggedIn,
  userId,
  isOnDaily,
  isOnBraindump,
  isTwelveTimeSystem,
  tags;

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
      case PrefsType.isTwelveTimeSystem:
        int? index = _prefs.getInt(type.prefsName);
        return index != null ? TimeSystem.values[index] as T? : null;
      default:
        return _prefs.getBool(type.prefsName) as T?;
    }
  }

  Future<bool> setPref<T>(PrefsType type, T pref) async {
    switch (type) {
      case PrefsType.userId:
        return await _prefs.setString(type.prefsName, pref as String);
      case PrefsType.tags:
        return await _prefs.setStringList(type.prefsName, pref as List<String>);
      case PrefsType.isTwelveTimeSystem:
        return await _prefs.setInt(type.prefsName, (pref as TimeSystem).index);
      default:
        return await _prefs.setBool(type.prefsName, pref as bool);
    }
  }

  Future<bool> removePref(PrefsType type) async {
    return await _prefs.remove(type.prefsName);
  }
}
