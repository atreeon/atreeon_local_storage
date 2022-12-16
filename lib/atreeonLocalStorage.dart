import 'package:atreeon_local_storage/HasData.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setLocalStorageValue<T>(String key, HasData<T> value, Future<SharedPreferences> prefsFuture) async {
  final prefs = await prefsFuture;

  if (value is HasData_none<T>) {
    await prefs.remove(key);
    return;
  }

  if (null is T) {
    if (value is HasData_yes<T>) {
      await prefs.setString(key, value.value?.toString() ?? "nullx");
      return;
    }
  } else {
    if (value is HasData_yes<T>) {
      await prefs.setString(key, value.value.toString());
      return;
    }
  }
}

Future<HasData<T>> _getLocalStorageValue<T>(String key, SharedPreferences prefs, T Function(String) parse) async {
  var value = prefs.getString(key);

  if (value == null) //
    return HasData_none();

  if (null is T && value == "nullx") //
    return HasData_yes(null as T);

  return HasData_yes(parse(value));
}

Future<HasData<double?>> getDoubleNullable(String key, SharedPreferences prefs) async => //
    _getLocalStorageValue<double?>(key, prefs, (value) => double.parse(value));

Future<HasData<double>> getDouble(String key, SharedPreferences prefs) async => //
    _getLocalStorageValue<double>(key, prefs, (value) => double.parse(value));

Future<HasData<String?>> getStringNullable(String key, SharedPreferences prefs) async => //
    _getLocalStorageValue<String?>(key, prefs, (value) => value);

Future<HasData<String>> getString(String key, SharedPreferences prefs) async => //
    _getLocalStorageValue<String>(key, prefs, (value) => value);

Future<HasData<int?>> getIntNullable(String key, SharedPreferences prefs) async => //
    _getLocalStorageValue<int?>(key, prefs, (value) => int.parse(value));

Future<HasData<int>> getInt(String key, SharedPreferences prefs) async => //
    _getLocalStorageValue<int>(key, prefs, (value) => int.parse(value));

Future<HasData<bool?>> getBoolNullable(String key, SharedPreferences prefs) async => //
    _getLocalStorageValue<bool?>(key, prefs, (value) => value == 'true');

Future<HasData<bool>> getBool(String key, SharedPreferences prefs) async => //
    _getLocalStorageValue<bool>(key, prefs, (value) => value == 'true');

Future<HasData<DateTime?>> getDateTimeNullable(String key, SharedPreferences prefs) async => //
    _getLocalStorageValue<DateTime?>(key, prefs, (value) => DateTime.parse(value));

Future<HasData<DateTime>> getDateTime(String key, SharedPreferences prefs) async => //
    _getLocalStorageValue<DateTime>(key, prefs, (value) => DateTime.parse(value));
