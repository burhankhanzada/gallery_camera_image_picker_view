import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

import 'bottom_sheet.dart';
import 'controller.dart';
import 'grid_view_item.dart';

class GallaryCameraImagePickerView extends StatefulWidget {
  const GallaryCameraImagePickerView({
    super.key,
    required this.controller,
  });

  final GalleryCameraImagePickerController controller;

  @override
  State<GallaryCameraImagePickerView> createState() =>
      _GallaryCameraImagePickerViewState();
}

class _GallaryCameraImagePickerViewState
    extends State<GallaryCameraImagePickerView> {
  final _gridViewKey = GlobalKey();
  final _scrollController = ScrollController();

  List<String> get _imagesList => widget.controller.pathList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListenableBuilder(
        listenable: widget.controller,
        builder: (context, child) {
          return widget.controller.hasNoImages ? _addImages() : _imagesGrid();
        },
      ),
    );
  }

  BoxDecoration _boxDecoration() {
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
        decoration: _boxDecoration(),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: _showBottomSheet,
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

  Future<void> _showBottomSheet() async {
    await GalleryCameraBottomSheet(
      context: context,
      controller: widget.controller,
    ).show();
  }

  Widget _imagesGrid() {
    return SingleChildScrollView(
      child: ReorderableBuilder(
        longPressDelay: const Duration(milliseconds: 100),
        scrollController: _scrollController,
        lockedIndices: [widget.controller.pathList.length],
        dragChildBoxDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 4),
              color: Colors.black38,
              blurRadius: 8,
              spreadRadius: 1,
            )
          ],
        ),
        onReorder: (orderUpdateEntities) {
          for (final orderUpdateEntity in orderUpdateEntities) {
            widget.controller.reOrderImage(
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
                    key: ValueKey(path),
                    onCancel: () {
                      widget.controller.removeImage(path);
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
        decoration: _boxDecoration(),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: _showBottomSheet,
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
