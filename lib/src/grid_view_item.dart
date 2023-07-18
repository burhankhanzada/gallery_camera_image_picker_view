import 'dart:io';

import 'package:flutter/material.dart';

import 'view_image.dart';

class GridViewItem extends StatefulWidget {
  const GridViewItem({
    super.key,
    required this.path,
    required this.onCancel,
  });

  final String path;
  final VoidCallback onCancel;

  @override
  State<GridViewItem> createState() => _GridViewItemState();
}

class _GridViewItemState extends State<GridViewItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        image(),
        close(),
      ],
    );
  }

  Widget image() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) {
                return ViewImage(path: widget.path);
              },
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image(
              fit: BoxFit.cover,
              image: FileImage(
                File(widget.path),
              ),
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                return child;
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const CircularProgressIndicator();
                // return Center(
                //   child: CircularProgressIndicator(
                //     value: loadingProgress.expectedTotalBytes != null
                //         ? loadingProgress.cumulativeBytesLoaded /
                //             loadingProgress.expectedTotalBytes!
                //         : null,
                //   ),
                // );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget close() {
    return Positioned(
      top: 0,
      right: 0,
      child: InkWell(
        onTap: widget.onCancel,
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
