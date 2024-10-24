import 'package:rick_and_morty/src/core/utils/key_value_storage/key_value_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template shared_preferences_storage}
/// Реализация [KeyValueStorage] для хранения данных в незащищенном виде в
/// [SharedPreferences].
///
/// Поддерживает следующие простые типы:
/// [int], [double], [String], [bool], [Iterable<String>].
/// {@endtemplate}
class SharedPreferencesStorage implements KeyValueStorage {
  /// {@macro shared_preferences_storage}
  const SharedPreferencesStorage({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  @override
  Future<T?> read<T extends Object>(String key) async {
    final value = _sharedPreferences.get(key);

    if (value == null) {
      return null;
    }

    if (value is T) {
      return value;
    } else if (T == (Iterable<String>) && value is Iterable) {
      return value.map((e) => e as String) as T;
    } else {
      throw Exception(
        'Read value by key "$key" has invalid type, expected "$T", received "${value.runtimeType}"',
      );
    }
  }

  @override
  Future<void> write<T extends Object>(
    String key, {
    required T value,
  }) =>
      switch (value) {
        final int value => _sharedPreferences.setInt(key, value),
        final double value => _sharedPreferences.setDouble(key, value),
        final String value => _sharedPreferences.setString(key, value),
        final bool value => _sharedPreferences.setBool(key, value),
        final Iterable<String> value => _sharedPreferences.setStringList(
            key,
            value.toList(),
          ),
        _ => throw Exception(
            '$T is not supported type for $SharedPreferencesStorage',
          ),
      };

  @override
  Future<void> remove(String key) => _sharedPreferences.remove(key);
}
