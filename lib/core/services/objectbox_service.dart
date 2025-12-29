// services/objectbox_service.dart
import 'package:url_player/objectbox.g.dart'; // Generated file

class ObjectBoxService {
  late final Store _store;

  Future<void> init() async {
    _store = await openStore();
  }

  Store get store => _store;

  void close() => _store.close();
}
