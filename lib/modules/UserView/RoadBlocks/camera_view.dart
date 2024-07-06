import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class TakePictureScreen extends StatefulWidget {
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  Timer? _timer;
  FlutterTts flutterTts = FlutterTts();
  List<CameraDescription>? cameras;
  CameraDescription? firstCamera;

  @override
  void initState() {
    super.initState();
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    cameras = await availableCameras();
    firstCamera = cameras?.first;
    if (firstCamera != null) {
      _controller = CameraController(
        firstCamera!,
        ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      _initializeControllerFuture = _controller.initialize().then((_) {
        _controller.setFlashMode(FlashMode.off); // Ensure flash is always off
        _timer = Timer.periodic(Duration(seconds: 5), (timer) {
          _takePicture();
        });
      });

      flutterTts.setLanguage("en-US");
      flutterTts.setVoice({"name": "en-us-x-sfg#female_1-local", "locale": "en-US"});
      flutterTts.setSpeechRate(0.5); // Adjust the speech rate here (0.0 to 1.0, where 0.5 is slower)
      setState(() {});
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;

      final image = await _controller.takePicture();

      await _uploadImage(image);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _uploadImage(XFile image) async {
    final uri = Uri.parse('https://object-detection-production.up.railway.app/process_image');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', image.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      print(responseData);
      var jsonResponse = jsonDecode(responseData);
      var labels = jsonResponse['labels'] as List<dynamic>;

      if (labels.isEmpty) {
        await flutterTts.speak("I cannot see anything");
      } else {
        Map<String, int> labelCounts = {};
        for (var label in labels) {
          labelCounts[label] = (labelCounts[label] ?? 0) + 1;
        }

        List<String> sentences = [];
        labelCounts.forEach((label, count) {
          if (count == 1) {
            sentences.add("one $label");
          } else {
            sentences.add("$count ${label}s");
          }
        });

        String sentence = "I can see " + sentences.join(", ");
        await flutterTts.speak(sentence);
      }
    } else {
      print('Failed to upload image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      body: firstCamera == null
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),

    );
  }
}
