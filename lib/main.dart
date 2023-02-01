import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_watermark/video_watermark.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Video Watermark',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () async {
          await FilePicker.platform.pickFiles(
            allowMultiple: false,
            allowedExtensions: ['mp4', 'mkv'],
          ).then((value) {
            var path = value!.files.first.path;
            VideoWatermark(
              sourceVideoPath: path!,
              watermark: Watermark(
                image: WatermarkSource.network(
                  'https://www.google.com/url?sa=i&url=https%3A%2F%2F1000logos.net%2Finstagram-logo%2F&psig=AOvVaw26vx7-qo8b4uxBmkhlrVe6&ust=1675329203700000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCNi77-L98_wCFQAAAAAdAAAAABAE',
                ),
                watermarkAlignment: WatermarkAlignment.topRight,
                watermarkSize: const WatermarkSize(100, 100),
              ),
              savePath: '${path.split('.')[0]}123',
              progress: (value) {
                log(value.toString());
              },
            );
          });
        },
        child: const Text('Choose'),
      ),
    );
  }
}
