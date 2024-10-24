import 'package:meta/meta.dart';

/// {@template key_value_storage}
/// Общий интерфейс хранилищ типа key-value.
/// {@endtemplate}
abstract interface class KeyValueStorage {
  Future<T?> read<T extends Object>(String key);

  Future<void> write<T extends Object>(
    String key, {
    required T value,
  });

  Future<void> remove(String key);
}

/// {@template storable_entry}
/// [StorableEntry] описывает запись в key-value хранилище под определенным [key].
/// Позволяет читать, записывать и удалять запись.
/// {@endtemplate}
abstract base class StorableEntry<T extends Object> {
  /// {@macro storable_entry}
  const StorableEntry();

  @factory
  StorableEntry<C> convertable<C extends Object>({
    required C Function(T) fromBase,
    required T Function(C) toBase,
  }) =>
      _ConvertableStorableEntry(
        base: this,
        fromBase: fromBase,
        toBase: toBase,
      );

  String get key;

  Future<T?> read();

  Future<void> write(T value);

  Future<void> remove();

  Future<void> saveIfNullRemove(T? value) => value == null ? remove() : write(value);
}

final class TypedEntry<T extends Object> extends StorableEntry<T> {
  TypedEntry({
    required KeyValueStorage storage,
    required this.key,
  }) : _storage = storage;

  final KeyValueStorage _storage;

  @override
  final String key;

  @override
  Future<T?> read() => _storage.read(key);

  @override
  Future<void> remove() => _storage.remove(key);

  @override
  Future<void> write(T value) => _storage.write(key, value: value);
}

final class _ConvertableStorableEntry<T extends Object, B extends Object> extends StorableEntry<T> {
  const _ConvertableStorableEntry({
    required StorableEntry<B> base,
    required T Function(B) fromBase,
    required B Function(T) toBase,
  })  : _base = base,
        _from = fromBase,
        _to = toBase;

  final StorableEntry<B> _base;
  final T Function(B) _from;
  final B Function(T) _to;

  @override
  String get key => _base.key;

  @override
  Future<T?> read() => _base.read().then((value) => value != null ? _from(value) : null);

  @override
  Future<void> remove() => _base.remove();

  @override
  Future<void> write(T value) => _base.write(_to(value));
}
