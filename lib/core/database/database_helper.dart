/// Generic database helper interface for CRUD operations.
/// 
/// Provides a type-safe abstraction over database operations.
/// Implementations should handle specific database technologies (e.g., ObjectBox).
/// 
/// Type parameter [T] represents the entity type stored in the database.
abstract class DatabaseHelper<T> {
  /// Inserts a new item into the database.
  /// Returns the ID of the inserted item.
  Future<int> insert(T item);
  
  /// Retrieves all items from the database.
  Future<List<T>> getAll();
  
  /// Retrieves an item by its ID.
  /// Returns null if the item doesn't exist.
  Future<T?> getById(int id);
  
  /// Updates an existing item in the database.
  /// Returns the ID of the updated item.
  Future<int> update(T item);
  
  /// Deletes an item by its ID.
  /// Returns the ID of the deleted item.
  Future<int> delete(int id);
  
  /// Queries items based on a condition function.
  /// Returns all items that match the condition.
  Future<List<T>> query(bool Function(T) condition);
}
