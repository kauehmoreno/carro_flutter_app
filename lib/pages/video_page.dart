import 'package:carro_flutter_app/src/cars/cars.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  final Car car;

  VideoPage(this.car);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController _controller;

  Car get car => widget.car;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        car.video)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, 
        // even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car.name),
      ),
      body: Center(
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}