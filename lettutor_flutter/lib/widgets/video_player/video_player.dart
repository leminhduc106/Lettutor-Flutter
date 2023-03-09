import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerPage extends StatefulWidget {
  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  bool _isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
  }

  Future<void> initializeVideoPlayer() async {
    const videoUrl =
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
    _controller = VideoPlayerController.network(videoUrl);
    await _controller.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio:
          _controller.value.aspectRatio, // or the aspect ratio of your video
      autoInitialize: true,
      looping: false,
      autoPlay: true,
      allowMuting: true,
      allowPlaybackSpeedChanging: false,
      showControlsOnInitialize: true,
      placeholder: Container(),
    );
    setState(() {
      _isControllerInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isControllerInitialized
        ? Chewie(
            controller: _chewieController,
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
