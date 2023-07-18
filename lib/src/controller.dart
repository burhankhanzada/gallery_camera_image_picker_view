import 'package:flutter/material.dart';

class GalleryCameraImagePickerController extends ChangeNotifier {
  final List<String> _pathList = [];
  List<String> get pathList => _pathList;

  bool get hasNoImages => pathList.isEmpty;

  void addImage(String path) {
    _pathList.add(path);
    notifyListeners();
  }

  void addImages(List<String> pathList) {
    _pathList.addAll(pathList);
    notifyListeners();
  }

  void reOrderImage(int oldIndex, int newIndex) {
    final oldItem = _pathList.removeAt(oldIndex);
    _pathList.insert(newIndex, oldItem);
    notifyListeners();
  }

  void removeImage(String path) {
    _pathList.remove(path);
    notifyListeners();
  }
}
