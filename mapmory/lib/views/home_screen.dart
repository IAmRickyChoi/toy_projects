import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapmory/models/location_memory.dart';
import 'package:mapmory/models/media_item.dart';
import 'package:mapmory/utils/icon_to_bitmap.dart';
import 'package:mapmory/view_models/trip_view_model.dart';
import 'package:mapmory/widgets/memory_input_sheet.dart';
import 'package:mapmory/views/location_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  final TripViewModel _viewModel = TripViewModel();
  Set<Marker> _markers = {};
  final Map<String, BitmapDescriptor> _markerBitmaps = {};
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      // 아이콘 비트맵이 먼저 준비된 후, 지도 초기화 및 마커 업데이트 진행
      _setupMarkerBitmaps().then((_) {
        _initLocation();
        _updateMarkers();
      });
      _isInit = false;
    }
  }

  Future<void> _setupMarkerBitmaps() async {
    for (var entry in MemoryInputSheet.markerIcons.entries) {
      final key = entry.key;
      final iconData = entry.value;
      final bitmap = await bitmapDescriptorFromIconData(iconData, Theme.of(context).primaryColor, 110.0);
      _markerBitmaps[key] = bitmap;
    }
  }

  Future<void> _initLocation() async {
    try {
      final position = await _viewModel.getCurrentLocation();
      if (position != null && mounted) {
        _moveCamera(position.latitude, position.longitude);
      }
    } catch (e) {
      debugPrint("위치 정보를 가져오는 데 실패했습니다: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('위치 정보를 가져올 수 없습니다. 권한을 확인해주세요.')),
        );
      }
    }
  }

  Future<void> _moveCamera(double lat, double lng) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 15));
  }

  void _updateMarkers() {
    final locations = _viewModel.getAllLocations();
    setState(() {
      _markers = locations.map((location) {
        return Marker(
          markerId: MarkerId(location.id),
          position: LatLng(location.lat, location.lng),
          icon: _markerBitmaps[location.markerIcon] ?? BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
            title: location.name,
            snippet: '저장된 추억 ${location.items.length}개',
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LocationDetailScreen(location: location),
              ),
            );
          },
        );
      }).toSet();
    });
  }

  void _showAddMemorySheet(LatLng latLng) {
    final mission = _viewModel.getRandomMission();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return MemoryInputSheet(
          lat: latLng.latitude,
          lng: latLng.longitude,
          missionTitle: mission,
          onSave: (path, type, visitedAt, markerIcon) {
            // 1. 첫 미디어 아이템 생성
            final newMediaItem = MediaItem(
              type: type,
              path: path,
              createdAt: visitedAt,
            );

            // 2. 새로운 장소(LocationMemory) 생성 및 미디어 아이템 추가
            final newLocation = LocationMemory(
              lat: latLng.latitude,
              lng: latLng.longitude,
              markerIcon: markerIcon!,
              name: mission, // 초기 이름은 미션으로 설정
              items: [newMediaItem],
            );

            // 3. ViewModel을 통해 저장
            _viewModel.addLocation(newLocation);
            _updateMarkers();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapmory', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 2,
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.5665, 126.9780), // 서울 중심
          zoom: 14,
        ),
        onMapCreated: (controller) {
          if (!_mapController.isCompleted) {
            _mapController.complete(controller);
          }
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: _markers,
        onLongPress: _showAddMemorySheet,
      ),
    );
  }
}
