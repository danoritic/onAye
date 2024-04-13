// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:html' as html;

import 'package:video_player/video_player.dart';

// class CustomVideoPlayer extends StatefulWidget {
//   const CustomVideoPlayer({
//     super.key,
//     this.width,
//     this.height,
//     required this.file,
//   });

//   final double? width;
//   final double? height;
//   final FFUploadedFile file;

//   @override
//   State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
// }

// class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// Here is a small code implementation of same.

class CustomVideoPlayer extends StatefulWidget {
  Uint8List? videoBytes;

  CustomVideoPlayer({super.key, this.width, this.height, required this.file}) {
    videoBytes = file.bytes;
  }

  final double? width;
  final double? height;
  final FFUploadedFile file;

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  late html.VideoElement _videoElement;

  @override
  void initState() {
    super.initState();
    _videoElement = html.VideoElement();

    // Register an event listener to track when the video has loaded
    _videoElement.addEventListener('loaded metadata', (_) {
      _initializeVideoPlayer();
    });

    // Convert the byte array to a blob and set it as the video source
    final blob = html.Blob([widget.videoBytes]);
    final url = html.Url.createObjectUrl(blob);
    _videoElement.src = url;
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoElement.pause();
    _videoElement.removeAttribute('src');
    html.Url.revokeObjectUrl(_videoElement.src);
    super.dispose();
  }

  Future<void> _initializeVideoPlayer() async {
    _controller = VideoPlayerController.network(_videoElement.currentSrc!);
    await _controller.initialize();
    await _controller.setLooping(true);
    _controller.play();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.value.isInitialized) {
      return SizedBox(
        height: widget.height,
        width: widget.width,
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      );
    } else {
      return Container();
    }
  }
}
