import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class RecordVideo extends StatefulWidget {
  const RecordVideo({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  _RecordVideoState createState() => _RecordVideoState();
}

class _RecordVideoState extends State<RecordVideo> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppProvider>(context).language;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey[800]),
          title: Text(
            lang.watchRecord,
            style: BaseTextStyle.heading2(
                fontSize: 20, color: BaseColor.secondaryBlue),
          ),
        ),
        body: Container(
          color: Colors.black,
          height: 200,
          child: Center(
            child: Chewie(
              controller: _chewieController,
            ),
          ),
        ),
      ),
    );
  }
}
