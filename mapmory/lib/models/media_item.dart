import 'package:uuid/uuid.dart';

enum MediaType { image, video }

class MediaItem {
  final String id;
  final MediaType type;
  final String path;
  final DateTime createdAt;

  MediaItem({
    required this.type,
    required this.path,
    required this.createdAt,
  }) : id = const Uuid().v4();
}
