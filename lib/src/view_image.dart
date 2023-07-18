import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewImage extends StatelessWidget {
  const ViewImage({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      minScale: 0.1,
      maxScale: 0.9,
      imageProvider: FileImage(
        File(path),
      ),
    );
  }
}
