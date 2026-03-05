import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? path;
  late VideoPlayerController _videoPlayerController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Container(
        color: colorScheme.primary,
        child: path == null
            ? Center(
                child: IconButton(
                  onPressed: () {
                    _selectVideo();
                    print("pressed");
                  },
                  icon: Icon(
                    Icons.video_call,
                    size: 50.0,
                    color: colorScheme.onPrimary,
                  ),
                ),
              )
            : _VideoPlayer(controller: _videoPlayerController),
      ),
    );
  }

  void _selectVideo() async {
    path = await ImagePicker().pickVideo(source: ImageSource.gallery);
    setState(() {
      if (path != null) {
        _videoPlayerController = VideoPlayerController.file(File(path!.path));
        _videoPlayerController.initialize();
        print(path!.path);
      }
    });
  }
}

class _VideoPlayer extends StatefulWidget {
  VideoPlayerController controller;
  _VideoPlayer({super.key, required this.controller});

  @override
  State<_VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<_VideoPlayer> {
  List<int> numbers = List.generate(100, (e) => e);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text("title"),
          pinned: true,
          expandedHeight: 400,
          floating: true,
          snap: true,
          stretch: true,
          flexibleSpace: FlexibleSpaceBar(
            background: AspectRatio(
              aspectRatio: widget.controller.value.aspectRatio,
              child: VideoPlayer(widget.controller),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Container(
              color: Colors.black,
              child: Center(
                child: Text(
                  numbers[index].toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }, childCount: numbers.length),
        ),
      ],
    );
  }
}
