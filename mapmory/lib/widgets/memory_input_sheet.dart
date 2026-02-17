import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mapmory/models/media_item.dart';

class MemoryInputSheet extends StatefulWidget {
  final double? lat;
  final double? lng;
  final String? missionTitle;
  final bool isAddingToExistingLocation;
  final Function(String path, MediaType type, DateTime visitedAt, String? markerIcon) onSave;

  const MemoryInputSheet({
    super.key,
    required this.onSave,
    this.lat,
    this.lng,
    this.missionTitle,
    this.isAddingToExistingLocation = false,
  });

  // 100개는 UI상 너무 많아, 주요 아이콘 40개로 확장
  static const Map<String, IconData> markerIcons = {
    'location': Icons.location_pin,
    'star': Icons.star,
    'heart': Icons.favorite,
    'flag': Icons.flag,
    'cafe': Icons.local_cafe,
    'restaurant': Icons.restaurant,
    'park': Icons.park,
    'hotel': Icons.hotel,
    'camera': Icons.camera_alt,
    'movie': Icons.movie_filter,
    'music': Icons.music_note,
    'book': Icons.menu_book,
    'shopping': Icons.shopping_cart,
    'work': Icons.work,
    'home': Icons.home,
    'school': Icons.school,
    'airport': Icons.airplanemode_active,
    'train': Icons.train,
    'car': Icons.directions_car,
    'bike': Icons.directions_bike,
    'hiking': Icons.hiking,
    'beach': Icons.beach_access,
    'mountain': Icons.filter_hdr,
    'forest': Icons.forest,
    'flower': Icons.local_florist,
    'paw': Icons.pets,
    'hospital': Icons.local_hospital,
    'bank': Icons.account_balance,
    'stadium': Icons.stadium,
    'museum': Icons.museum,
    'palette': Icons.palette,
    'anchor': Icons.anchor,
    'build': Icons.build,
    'cake': Icons.cake,
    'celebration': Icons.celebration,
    'controller': Icons.sports_esports,
    'desktop': Icons.desktop_windows,
    'fitness': Icons.fitness_center,
    'ship': Icons.directions_boat,
    'lightbulb': Icons.lightbulb,
  };

  @override
  State<MemoryInputSheet> createState() => _MemoryInputSheetState();
}

class _MemoryInputSheetState extends State<MemoryInputSheet> {
  final ImagePicker _picker = ImagePicker();
  XFile? _mediaFile;
  MediaType? _mediaType;
  DateTime _selectedDate = DateTime.now();
  late String _selectedIconKey;

  @override
  void initState() {
    super.initState();
    _selectedIconKey = MemoryInputSheet.markerIcons.keys.first;
  }

  Future<void> _pickMedia(MediaType type) async {
    final XFile? file;
    if (type == MediaType.image) {
      file = await _picker.pickImage(source: ImageSource.gallery);
    } else {
      file = await _picker.pickVideo(source: ImageSource.gallery);
    }

    if (file != null) {
      setState(() {
        _mediaFile = file;
        _mediaType = type;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveMemory() {
    if (_mediaFile == null || _mediaType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('추억을 기록할 사진이나 영상을 선택해주세요.')),
      );
      return;
    }
    final iconToSave = widget.isAddingToExistingLocation ? null : _selectedIconKey;
    widget.onSave(_mediaFile!.path, _mediaType!, _selectedDate, iconToSave);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 20,
        left: 20,
        right: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (!widget.isAddingToExistingLocation)
              SizedBox(
                width: double.infinity,
                child: Text(
                  widget.missionTitle ?? '새로운 추억 만들기',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            if (widget.isAddingToExistingLocation)
               SizedBox(
                width: double.infinity,
                child: Text(
                  '추억 추가하기',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 20),
            _buildMediaPreview(),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.image),
                    label: const Text('사진 추가'),
                    onPressed: () => _pickMedia(MediaType.image),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.video_library),
                    label: const Text('영상 추가'),
                    onPressed: () => _pickMedia(MediaType.video),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '방문 날짜: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('날짜 변경'),
                ),
              ],
            ),
            if (!widget.isAddingToExistingLocation) ...[
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Text('마커 아이콘 선택', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 10),
              _buildIconSelector(),
            ],
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('추억 저장하기'),
                onPressed: _saveMemory,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildIconSelector() {
    final iconKeys = MemoryInputSheet.markerIcons.keys.toList();
    return SizedBox(
      height: 150, // GridView 높이 제한
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: iconKeys.length,
        itemBuilder: (context, index) {
          final key = iconKeys[index];
          final iconData = MemoryInputSheet.markerIcons[key]!;
          final isSelected = key == _selectedIconKey;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIconKey = key;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.2) : Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
                  width: 1.5,
                ),
              ),
              child: Icon(
                iconData,
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey[700],
                size: 30,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMediaPreview() {
    if (_mediaFile == null) {
      return Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[400]!),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.photo_library, size: 50, color: Colors.grey),
              SizedBox(height: 8),
              Text('선택된 사진이나 영상이 없습니다.'),
            ],
          ),
        ),
      );
    }

    if (_mediaType == MediaType.image) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          File(_mediaFile!.path),
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }

    // For video
    return Container(
      height: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.videocam, size: 40, color: Colors.black54),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '영상 선택 완료:\n${_mediaFile!.name}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
