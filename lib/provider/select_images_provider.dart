import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class SelectImagesProvider extends ChangeNotifier {
  List<Uint8List> _images = [];

  Future setImages(List<XFile> newImages) async {
    if (newImages != null && newImages.isNotEmpty) {
      _images.clear();
      // map을 이용해서 list를 만들면 왜인지는 모르겠지만 잘 안된다...
      // images.map((e) async => {_images.add(await (e.readAsBytes()))});
      newImages.forEach((file) async {
        _images.add(await file.readAsBytes());
      });
    }
    notifyListeners();
  }

  void removeImage(int idx) {
    if (_images.length >= idx) {
      _images.removeAt(idx);
      notifyListeners();
    }
  }

  List<Uint8List> get images => _images;
}
