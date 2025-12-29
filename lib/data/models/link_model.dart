// Data model for Link entity with ObjectBox annotations.
//
// This model is used for database persistence and includes ObjectBox
// annotations for entity mapping. It can be converted to/from LinkEntity.
import 'package:objectbox/objectbox.dart';
import '../../domain/entities/link_entity.dart';

@Entity()
class LinkModel {
  @Id()
  int id;

  String title;
  String url;
  DateTime createdAt;

  LinkModel({
    this.id = 0,
    required this.title,
    required this.url,
    required this.createdAt,
  });

  /// Creates a LinkModel from a domain entity.
  factory LinkModel.fromEntity(LinkEntity entity) {
    return LinkModel(
      id: entity.id,
      title: entity.title,
      url: entity.url,
      createdAt: entity.createdAt,
    );
  }

  /// Converts this model to a domain entity.
  LinkEntity toEntity() =>
      LinkEntity(id: id, title: title, url: url, createdAt: createdAt);
}
