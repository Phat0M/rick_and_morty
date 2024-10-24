// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rick_and_morty/src/core/utils/key_value_storage/key_value_storage.dart';
import 'package:rick_and_morty/src/core/utils/refined_logger.dart';


class SecuredStorage implements KeyValueStorage {
  const SecuredStorage({
    required FlutterSecureStorage secureStorage,
    required RefinedLogger logger,
  })  : _secureStorage = secureStorage,
        _logger = logger;

  final FlutterSecureStorage _secureStorage;
  final RefinedLogger _logger;

  @override
  Future<T?> read<T extends Object>(String key) async {
    String? value;
    try {
      value = await _secureStorage.read(key: key);
    } on Object catch (e, stackTrace) {
      _logger.warn(
        "Couldn't read value by key: $key",
        error: e,
        stackTrace: stackTrace,
      );
      value = null;
    }

    if (value == null) {
      return null;
    }

    final result = switch (T) {
      int => int.tryParse(value) as T?,
      double => double.tryParse(value) as T?,
      String => value as T?,
      bool => bool.tryParse(value) as T?,
      const (Iterable<String>) => _tryParseToIterable(value) as T?,
      _ => null,
    };

    if (result == null) {
      throw Exception(
        'Read value "$value" by key "$key" has invalid type, expected "$T"',
      );
    }

    return result;
  }

  Iterable<String>? _tryParseToIterable(String input) {
    try {
      final trimmed = input.substring(1, input.length - 1).trim();

      final result = trimmed.split(', ').map((s) => s.trim());

      return result;
    } on Object {
      return null;
    }
  }

  @override
  Future<void> write<T extends Object>(
    String key, {
    required T value,
  }) {
    switch (value) {
      case int _:
      case double _:
      case String _:
      case bool _:
        break;
      default:
        throw Exception(
          '$T is not supported type for $SecuredStorage',
        );
    }

    return _secureStorage.write(key: key, value: value.toString());
  }

  @override
  Future<void> remove(String key) async {
    try {
      await _secureStorage.delete(key: key);
    } on Object catch (error, stackTrace) {
      _logger.warn(
        "Couldn't remove value by key: $key",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
