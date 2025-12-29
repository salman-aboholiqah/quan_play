// data/datasources/link_local_datasource.dart

import 'package:url_player/core/database/database_helper.dart';
import 'package:url_player/core/error/exceptions.dart';
import 'package:url_player/data/models/link_model.dart';

class LinkLocalDataSource {
  final DatabaseHelper<LinkModel> db;
  LinkLocalDataSource(this.db);

  /// Guards database operations and provides meaningful error messages.
  Future<T> _guard<T>(Future<T> Function() operation, String message) async {
    try {
      return await operation();
    } catch (e) {
      throw CacheException('$message: ${e.toString()}');
    }
  }

  Future<int> insertLink(LinkModel link) =>
      _guard(() => db.insert(link), 'Insert failed');

  Future<List<LinkModel>> getAllLinks() =>
      _guard(() => db.getAll(), 'Fetching all links failed');

  Future<LinkModel?> getLinkById(int id) =>
      _guard(() => db.getById(id), 'Fetching link by ID failed');

  Future<int> updateLink(LinkModel link) =>
      _guard(() => db.update(link), 'Update failed');

  Future<int> deleteLink(int id) =>
      _guard(() => db.delete(id), 'Delete failed');

  Future<List<LinkModel>> searchLinks(String query) => _guard(
    () => db.query(
      (link) =>
          link.title.toLowerCase().contains(query.toLowerCase()) ||
          link.url.toLowerCase().contains(query.toLowerCase()),
    ),
    'Search failed',
  );
}
