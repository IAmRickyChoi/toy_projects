import 'package:mapmory/models/location_memory.dart';
import 'package:mapmory/models/media_item.dart';

class TripRepository {
  static final TripRepository _instance = TripRepository._internal();
  factory TripRepository() => _instance;
  TripRepository._internal();

  final List<LocationMemory> _locations = [];

  List<LocationMemory> fetchAllLocations() => _locations;

  void addLocation(LocationMemory location) => _locations.add(location);

  void addMediaToLocation(String locationId, MediaItem item) {
    try {
      final location = _locations.firstWhere((loc) => loc.id == locationId);
      location.items.add(item);
    } catch (e) {
      // 해당 ID를 가진 장소가 없을 경우.
      print("Error adding media: Location with ID $locationId not found.");
    }
  }
}