import 'package:flutter/material.dart';
import 'package:gallery_camera_image_picker_view/gallery_camera_image_picker_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final controller = GalleryCameraImagePickerController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: GallaryCameraImagePickerView(
            controller: controller,
          ),
        ),
      ),
    );
  }
}
