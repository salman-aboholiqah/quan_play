// ObjectBox implementation of the DatabaseHelper interface.
//
// Provides high-performance local database operations using ObjectBox.
// This is a generic implementation that works with any ObjectBox entity type.
//
// Type parameter [T] must be an ObjectBox entity class.
import 'package:objectbox/objectbox.dart';
import 'database_helper.dart';

class ObjectBoxDatabaseHelper<T> implements DatabaseHelper<T> {
  final Store store;
  final Box<T> box;

  /// Private constructor. Use [create] factory method instead.
  ObjectBoxDatabaseHelper._(this.store, this.box);

  /// Factory method to create an ObjectBoxDatabaseHelper instance.
  ///
  /// [store] is the ObjectBox Store instance.
  /// [type] is the type of entity (used for type inference).
  ///
  /// Returns a configured ObjectBoxDatabaseHelper ready for use.
  static Future<ObjectBoxDatabaseHelper<T>> create<T>(
    Store store,
    Type type,
  ) async {
    final box = store.box<T>();
    return ObjectBoxDatabaseHelper._(store, box);
  }

  @override
  Future<int> insert(T item) async {
    return box.put(item);
  }

  @override
  Future<List<T>> getAll() async {
    return box.getAll();
  }

  @override
  Future<T?> getById(int id) async {
    return box.get(id);
  }

  @override
  Future<int> update(T item) async {
    return box.put(item);
  }

  @override
  Future<int> delete(int id) async {
    box.remove(id);
    return id;
  }

  @override
  Future<List<T>> query(bool Function(T) condition) async {
    return box.getAll().where(condition).toList();
  }
}
