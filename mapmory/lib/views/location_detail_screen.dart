import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mapmory/models/location_memory.dart';
import 'package:mapmory/models/media_item.dart';
import 'package:mapmory/view_models/trip_view_model.dart';
import 'package:mapmory/views/image_viewer_screen.dart';
import 'package:mapmory/views/video_player_screen.dart';
import 'package:mapmory/widgets/memory_input_sheet.dart';

class LocationDetailScreen extends StatefulWidget {
  final LocationMemory location;

  const LocationDetailScreen({super.key, required this.location});

  @override
  State<LocationDetailScreen> createState() => _LocationDetailScreenState();
}

class _LocationDetailScreenState extends State<LocationDetailScreen> {
  final TripViewModel _viewModel = TripViewModel();

  void _showAddMediaSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return MemoryInputSheet(
          isAddingToExistingLocation: true,
          onSave: (path, type, visitedAt, markerIcon) {
            // markerIcon은 이 경우 null 입니다.
            final newItem = MediaItem(
              type: type,
              path: path,
              createdAt: visitedAt,
            );
            _viewModel.addMediaToLocation(widget.location.id, newItem);
            // UI를 즉시 새로고침합니다.
            setState(() {});
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location.name),
      ),
      body: widget.location.items.isEmpty
          ? const Center(
              child: Text(
                '저장된 추억이 없습니다.\n아래 버튼을 눌러 추가해보세요!',
                textAlign: TextAlign.center,
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: widget.location.items.length,
              itemBuilder: (context, index) {
                final item = widget.location.items[index];
                return _MediaItemTile(item: item);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMediaSheet,
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}

class _MediaItemTile extends StatelessWidget {
  final MediaItem item;

  const _MediaItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.type == MediaType.image) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageViewerScreen(imagePath: item.path),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoPlayerScreen(videoPath: item.path),
            ),
          );
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (item.type == MediaType.image)
              Image.file(
                File(item.path),
                fit: BoxFit.cover,
              )
            else
              Container(
                color: Colors.black,
                child: const Icon(
                  Icons.play_circle_outline,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            if (item.type == MediaType.video)
              const Positioned(
                top: 4,
                right: 4,
                child: Icon(Icons.videocam, color: Colors.white, size: 16),
              ),
          ],
        ),
      ),
    );
  }
}
