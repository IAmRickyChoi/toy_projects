import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:mapmory/models/location_memory.dart';
import 'package:mapmory/models/media_item.dart';
import 'package:mapmory/repositories/trip_repository.dart';

class TripViewModel {
  final TripRepository _tripRepository = TripRepository();

  final List<String> _missions = [
    "가장 좋아하는 카페에서 인증샷 찍기",
    "동네 서점에서 책 한 권 사기",
    "공원에서 하늘 사진 찍기",
    "새로운 맛집 탐방하고 음식 사진 남기기",
    "가장 높은 곳에 올라가서 풍경 담기",
    "나만 아는 장소에서 영상 기록하기",
  ];

  List<LocationMemory> getAllLocations() {
    return _tripRepository.fetchAllLocations();
  }

  void addLocation(LocationMemory location) {
    _tripRepository.addLocation(location);
  }

  void addMediaToLocation(String locationId, MediaItem item) {
    _tripRepository.addMediaToLocation(locationId, item);
  }

  String getRandomMission() {
    final random = Random();
    return _missions[random.nextInt(_missions.length)];
  }

  Future<bool> checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return false;
      }
    }
    return true;
  }

  Future<Position?> getCurrentLocation() async {
    bool hasPermission = await checkPermission();

    if(!hasPermission){
      return null;
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high)
    );
  }
}
