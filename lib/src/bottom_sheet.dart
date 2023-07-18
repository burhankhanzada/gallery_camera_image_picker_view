import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../gallery_camera_image_picker_view.dart';

class GalleryCameraBottomSheet {
  GalleryCameraBottomSheet({
    required this.context,
    required this.controller,
  });

  final BuildContext context;
  final GalleryCameraImagePickerController controller;

  Future<void> show() async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            item('Gallery', Icons.collections, () {
              pickImagesFromGallary(context);
            }),
            item('Camera', Icons.camera_alt, () {
              pickImagesFromCamera(context);
            }),
          ],
        );
      },
    );
  }

  Widget item(
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Future<void> pickImagesFromGallary(BuildContext context) async {
    if (context.mounted) Navigator.pop(context);
    final result = await ImagePicker().pickMultiImage();
    if (result.isNotEmpty) {
      final pathList = result.map((e) => e.path).toList();
      controller.addImages(pathList);
    }
  }

  Future<void> pickImagesFromCamera(BuildContext context) async {
    if (context.mounted) Navigator.pop(context);
    final result = await ImagePicker().pickImage(source: ImageSource.camera);
    if (result != null) {
      controller.addImage(result.path);
    }
  }
}
