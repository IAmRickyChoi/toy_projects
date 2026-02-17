import 'package:mapmory/models/media_item.dart';
import 'package:uuid/uuid.dart';

class LocationMemory {
  final String id;
  final double lat;
  final double lng;
  String name;
  final String markerIcon;
  final List<MediaItem> items;

  LocationMemory({
    required this.lat,
    required this.lng,
    required this.markerIcon,
    List<MediaItem>? items,
    String? name,
  })  : id = const Uuid().v4(),
        items = items ?? [],
        name = name ?? '새로운 장소';
}
