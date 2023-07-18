import 'package:flutter/material.dart';
import 'package:gallery_camera_image_picker_view/gallery_camera_image_picker_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: GallaryCameraImagePickerView(),
        ),
      ),
    );
  }
}
