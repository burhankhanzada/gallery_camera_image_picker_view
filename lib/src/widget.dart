import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

import 'bottom_sheet.dart';
import 'controller.dart';
import 'grid_view_item.dart';

class GallaryCameraImagePickerView extends StatefulWidget {
  const GallaryCameraImagePickerView({
    super.key,
  });

  @override
  State<GallaryCameraImagePickerView> createState() =>
      _GallaryCameraImagePickerViewState();
}

class _GallaryCameraImagePickerViewState
    extends State<GallaryCameraImagePickerView> {
  final _gridViewKey = GlobalKey();

  final _scrollController = ScrollController();

  final controller = GalleryCameraImagePickerController();

  List<String> get _imagesList => controller.pathList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          if (controller.pathList.isEmpty) {
            return _addImages();
          }
          return _imagesGrid();
        },
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      border: DashedBorder.fromBorderSide(
        dashLength: 16,
        side: BorderSide(
          width: 2,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(16),
      ),
    );
  }

  Widget _addImages() {
    return SizedBox(
      height: 200,
      child: DecoratedBox(
        decoration: boxDecoration(),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: showBottomSheet,
          child: Center(
            child: Text(
              'Add Images',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showBottomSheet() async {
    await GalleryCameraBottomSheet(
      context: context,
      controller: controller,
    ).show();
  }

  Widget _imagesGrid() {
    return SingleChildScrollView(
      child: ReorderableBuilder(
        scrollController: _scrollController,
        dragChildBoxDecoration: const BoxDecoration(
          boxShadow: [],
        ),
        onReorder: (orderUpdateEntities) {
          for (final orderUpdateEntity in orderUpdateEntities) {
            controller.reOrderImage(
              orderUpdateEntity.oldIndex,
              orderUpdateEntity.newIndex,
            );
          }
        },
        builder: (children) {
          return GridView(
            key: _gridViewKey,
            shrinkWrap: true,
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              crossAxisCount: 3,
            ),
            children: children,
          );
        },
        children: _imagesList
                .map<Widget>(
                  (path) => GridViewItem(
                    path: path,
                    key: UniqueKey(),
                    onCancel: () {
                      controller.removeImage(path);
                    },
                  ),
                )
                .toList() +
            [_addMore()],
      ),
    );
  }

  Widget _addMore() {
    return SizedBox(
      key: UniqueKey(),
      child: DecoratedBox(
        decoration: boxDecoration(),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: showBottomSheet,
          child: Center(
            child: Text(
              'Add More',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
