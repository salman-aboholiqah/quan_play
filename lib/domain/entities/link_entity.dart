/// Domain entity representing a video link.
/// 
/// This is a pure domain object that represents a saved video link
/// in the business logic layer. It contains no framework dependencies.
class LinkEntity {
  /// Unique identifier for the link. 0 indicates a new, unsaved link.
  int id;
  
  /// Display title for the link.
  final String title;
  
  /// Video URL to be played.
  final String url;
  
  /// Timestamp when the link was created.
  final DateTime createdAt;

  LinkEntity({
    this.id = 0,
    required this.title,
    required this.url,
    required this.createdAt,
  });
}
