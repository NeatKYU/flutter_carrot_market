import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class ImageStroage {
  static Future<List<String>> UploadImages(List<Uint8List> images) async {
    if (FirebaseAuth.instance.currentUser == null) {
      return [];
    }

    String userKey = FirebaseAuth.instance.currentUser!.uid;
    String timeInMilli = DateTime.now().millisecondsSinceEpoch.toString();

    var metaData = SettableMetadata(contentType: 'image/jpeg');

    List<String> downloadUrls = [];

    for (int i = 0; i < images.length; i++) {
      Reference ref = FirebaseStorage.instance
          .ref('images/${userKey}_${timeInMilli}/${i}.png');
      await ref.putData(images[i], metaData);

      downloadUrls.add(await ref.getDownloadURL());
    }

    return downloadUrls;
  }
}
