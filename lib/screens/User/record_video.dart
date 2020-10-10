import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
class CamVideo extends StatefulWidget {
  @override
  _CamVideoState createState() => _CamVideoState();
}
class _CamVideoState extends State<CamVideo> {
  CameraController _controller;
  Future<void> _initCamFuture;
  @override
  void initState() {
    super.initState();
    _initApp();
  }
  _initApp() async {
    final cameras = await availableCameras();
    final firstCam = cameras.first;
    _controller = CameraController(
      firstCam,
      ResolutionPreset.medium,
    );
    _initCamFuture = _controller.initialize();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Record Video")),
      body: FutureBuilder<void>(
        future: _initCamFuture,
        builder: (context, snapshot) {

          return CameraPreview(_controller);

        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.videocam),
        onPressed: () async {
          try {
            await _initCamFuture;
            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );
            await _controller.startVideoRecording(path);
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}